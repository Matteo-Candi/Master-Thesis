import argparse

from transformers import AutoModelForCausalLM, AutoTokenizer
from datasets import DatasetDict
import torch

from utils import tokenize_and_save_dataset, create_dataloader, train_custom_model, validation_step, get_idxs_list_NOSE, send_email_notification
from model_shrink import customize_model


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("--nose_step", required=True)
    args = parser.parse_args()

    device: str = 'cuda'
    model_name: str = "m-a-p/OpenCodeInterpreter-DS-6.7B"
    dataset_name: str = "m-a-p/Code-Feedback"
    tokenized_dataset_path: str = "tokenized_dataset"

    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float16)

    batch_size = 1

    seed = 23
    torch.cuda.manual_seed_all(seed)

    # Uncomment the following line to download, tokenize and save the dataset
    # tokenize_and_save_dataset(dataset_name, tokenized_dataset_path, tokenizer, seed=23)

    # Load the tokenized dataset and convert the data to tensors
    tokenized_dataset = DatasetDict.load_from_disk(tokenized_dataset_path)

    # train_dataloader = create_dataloader(tokenized_dataset['train'].select(range(10)), tokenizer, batch_size)
    # val_dataloader = create_dataloader(tokenized_dataset['validation'].select(range(10)), tokenizer, batch_size)
    train_dataloader = create_dataloader(tokenized_dataset['train'], tokenizer, batch_size)
    val_dataloader = create_dataloader(tokenized_dataset['validation'], tokenizer, batch_size)


    S = get_idxs_list_NOSE(args.nose_step)

    # vv = validation_step(model, val_dataloader, device)
    # print(f'Baseline Loss: {vv}')

    reload_checkpoint_path = None
    reload_checkpoint_path = 'results_and_checkpoints/nose_step_0/checkpoint_epoch_9_step_30000.pth'


    try:
        train_custom_model(model,
                            S,
                            num_epochs=10,
                            learning_rate=5e-6,
                            gradient_accumulation_steps=1,
                            train_dataloader=train_dataloader,
                            val_dataloader=val_dataloader,
                            device=device,
                            nose_step=args.nose_step,
                            reload_checkpoint_path=reload_checkpoint_path,
                            )
    except Exception as e:
        send_email_notification(f"Error encountered: {e}")



if __name__ == "__main__":

    main()




# BASELINE Loss
# Baseline Loss: 0.8105868452329592
