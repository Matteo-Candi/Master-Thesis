from tqdm import tqdm
import json
import time
import os

from transformers import DataCollatorForLanguageModeling, get_scheduler, AdamW
from datasets import load_dataset, DatasetDict
from torch.utils.data import DataLoader
import torch

from model_shrink import customize_model




class TokenizedDataset(torch.utils.data.Dataset):
    def __init__(self, dataset):
        self.dataset = dataset

    def __len__(self):
        return len(self.dataset)

    def __getitem__(self, idx):
        item = self.dataset[idx]
        # Ensure the output is tensors
        return {key: torch.tensor(val) for key, val in item.items()}


def tokenize_function(examples, tokenizer) -> None:
    chat_template = tokenizer.apply_chat_template(examples["messages"], tokenize=False, add_generation_prompt=False)
    return tokenizer(chat_template, padding=True)


def tokenize_and_save_dataset(data_id, tokenized_dataset_path, tokenizer, seed):
    dataset = load_dataset(data_id)
    tokenized_dataset = dataset.map(lambda examples: tokenize_function(examples, tokenizer=tokenizer), remove_columns=["id", "messages"])

    split_datasets = tokenized_dataset['train'].train_test_split(test_size=0.05, shuffle=True, seed=seed)
    split_datasets = DatasetDict({
        'train': tokenized_dataset['train'],
        'validation': split_datasets['test']
    })

    split_datasets.save_to_disk(tokenized_dataset_path)


def create_dataloader(tokenized_dataset, tokenizer, batch_size=1):

    tokenized_dataset = TokenizedDataset(tokenized_dataset)
    data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)
    dataloader = DataLoader(tokenized_dataset, batch_size=batch_size, collate_fn=data_collator)

    return dataloader


def get_idxs_list_NOSE(idx):
    '''
    Returning list of indexes S from the selected NOSE step
    '''

    results_file_path = '../NOSE_results.json'
    with open(results_file_path, 'r') as f:
        nose_results = json.load(f)

    S = nose_results[f'step_{idx}']['S']

    return S


def validation_step(model, val_dataloader, device):

    model.eval()
    model.to(device)

    val_loss = 0

    print('Validation step...')
    for batch in tqdm(val_dataloader):
        batch.to(device)
        with torch.no_grad():
            outputs = model(**batch)
            val_loss += outputs.loss.item()

    avg_val_loss = val_loss / len(val_dataloader)

    return avg_val_loss


def train_custom_model(model, S, num_epochs, learning_rate, gradient_accumulation_steps, train_dataloader, val_dataloader, device, nose_step):

    # Prepare optimizer, only update unfrozen parameters
    optimizer = AdamW(filter(lambda p: p.requires_grad, model.parameters()), lr=learning_rate, no_deprecation_warning=True)

    # Scheduler
    num_training_steps = num_epochs * len(train_dataloader)
    lr_scheduler = get_scheduler(
        name="linear", optimizer=optimizer, num_warmup_steps=0, num_training_steps=num_training_steps
    )

    checkpoint_path = f'results_and_checkpoints/nose_step_{nose_step}'
    if not os.path.exists(checkpoint_path):
        os.makedirs(checkpoint_path)

    for epoch in range(num_epochs):

        model.train()
        model.to(device)

        scale_factor = 1 - ((epoch+1) / num_epochs)
        customize_model(model, S, scale_factor)
        train_loss = 0
        start_time = time.time()

        print(f"\nEpoch {epoch+1}/{num_epochs}...\n")

        for step, batch in enumerate(tqdm(train_dataloader)):

            batch.to(device)
            outputs = model(**batch)
            loss = outputs.loss
            train_loss += loss.item()
            loss = loss / gradient_accumulation_steps
            loss.backward()

            if (step + 1) % gradient_accumulation_steps == 0:
                optimizer.step()
                lr_scheduler.step()
                optimizer.zero_grad()

        if (step + 1) % gradient_accumulation_steps != 0:
            optimizer.step()
            lr_scheduler.step()
            optimizer.zero_grad()

        end_time = time.time()

        # Epoch values
        epoch_time = round((end_time - start_time) / 60, 2)
        avg_val_loss = round(validation_step(model, val_dataloader, device), 4)
        avg_train_loss = round(train_loss / len(train_dataloader), 4)

        print(f"Epoch {epoch+1}: [time: {epoch_time} min  - loss: {avg_train_loss} - val_loss: {avg_val_loss}]\n")


        # Saving checkpoints and results 
        checkpoint = {
                    'epoch': epoch + 1,
                    'S_layers_state': [(model.model.layers[s].mlp.state_dict(), model.model.layers[s].post_attention_layernorm.state_dict()) for s in S],
                    'optimizer_state_dict': optimizer.state_dict(),
                    'loss': loss.item(),
                    }
        
        if epoch != 0:
            old_epoch_checkpoint_path = checkpoint_path + f'/checkpoint_epoch_{epoch}.pth'
            os.remove(old_epoch_checkpoint_path)

        epoch_checkpoint_path = checkpoint_path + f'/checkpoint_epoch_{epoch + 1}.pth'
        if epoch + 1 == num_epochs:
            epoch_checkpoint_path = checkpoint_path + '/final_checkpoint.pth'

        torch.save(checkpoint, epoch_checkpoint_path)

        epochs_metrics = {
            'time': epoch_time,
            'train_loss': avg_train_loss,
            'val_loss': avg_val_loss
        }

        epochs_metrics_file = checkpoint_path + '/epochs_metrics.json'

        if os.path.exists(epochs_metrics_file):
            with open(epochs_metrics_file, 'r') as file:
                data = json.load(file)
        else:
            data = {}

        data[f'epoch_{epoch + 1}'] = epochs_metrics

        with open(epochs_metrics_file, 'w') as file:
            json.dump(data, file, indent=4)

        print(f"Epoch {epoch+1} checkpoint saved!\n")


    print("Training complete.")


