from transformers import DataCollatorForLanguageModeling, get_scheduler, AdamW
from datasets import load_dataset, DatasetDict
from torch.utils.data import DataLoader
import torch

from tqdm import tqdm




class TokenizedDataset(torch.utils.data.Dataset):
    def __init__(self, dataset):
        self.dataset = dataset

    def __len__(self):
        return len(self.dataset)

    def __getitem__(self, idx):
        item = self.dataset[idx]
        # Ensure the output is tensors
        return {key: torch.tensor(val) for key, val in item.items()}


def tokenize_function(examples, tokenizer):
    chat_template = tokenizer.apply_chat_template(examples["messages"], tokenize=False, add_generation_prompt=False)
    return tokenizer(chat_template, padding=True)


def tokenize_and_save_dataset(data_id, tokenized_dataset_path, tokenizer):
    dataset = load_dataset(data_id)
    tokenized_dataset = dataset.map(lambda examples: tokenize_function(examples, tokenizer=tokenizer), remove_columns=["id", "messages"])

    split_datasets = tokenized_dataset['train'].train_test_split(test_size=0.1)
    split_datasets = DatasetDict({
        'train': split_datasets['train'],
        'validation': split_datasets['test']
    })

    split_datasets.save_to_disk(tokenized_dataset_path)

    return


def create_dataloader(tokenized_dataset, tokenizer, batch_size=1):

    tokenized_dataset = TokenizedDataset(tokenized_dataset)
    data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)
    dataloader = DataLoader(tokenized_dataset, batch_size=batch_size, collate_fn=data_collator)

    return dataloader


def train_custom_model(model, num_epochs, learning_rate, gradient_accumulation_steps, train_dataloader, eval_dataloader, device):

    # Prepare optimizer, only update unfrozen parameters
    optimizer = AdamW(filter(lambda p: p.requires_grad, model.parameters()), lr=learning_rate)

    # Scheduler
    num_training_steps = num_epochs * len(train_dataloader)
    lr_scheduler = get_scheduler(
        name="linear", optimizer=optimizer, num_warmup_steps=0, num_training_steps=num_training_steps
    )

    # Training loop
    model.train()
    model.to(device)

    for epoch in range(num_epochs):
        for step, batch in enumerate(tqdm(train_dataloader)):

            batch.to(device)

            outputs = model(**batch)
            loss = outputs.loss
            loss = loss / gradient_accumulation_steps
            loss.backward()

            if (step + 1) % gradient_accumulation_steps == 0:
                optimizer.step()
                lr_scheduler.step()
                optimizer.zero_grad()

        # Evaluate after each epoch
        model.eval()
        eval_loss = 0
        for batch in eval_dataloader:
            batch.to(device)
            with torch.no_grad():
                outputs = model(**batch)
                eval_loss += outputs.loss.item()

        avg_eval_loss = eval_loss / len(eval_dataloader)
        print(f"Epoch {epoch + 1} - Evaluation Loss: {avg_eval_loss}\n")
        model.train()

    print("Training complete.")
