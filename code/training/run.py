from transformers import AutoModelForCausalLM, AutoTokenizer
from datasets import DatasetDict
import torch

from utils import tokenize_and_save_dataset, create_dataloader, train_custom_model


device: str = 'cuda'
model_name: str = "m-a-p/OpenCodeInterpreter-DS-6.7B"
dataset_name: str = "m-a-p/Code-Feedback"
tokenized_dataset_path: str = "tokenized_dataset"

tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float16)


# Uncomment the following line to download, tokenize and save the dataset
tokenize_and_save_dataset(dataset_name, tokenized_dataset_path, tokenizer)

batch_size = 1

# Load the tokenized dataset and convert the data to tensors
tokenized_dataset = DatasetDict.load_from_disk(tokenized_dataset_path)

# train_dataloader = create_dataloader(tokenized_dataset['train'].select(range(100)), tokenizer, batch_size)
train_dataloader = create_dataloader(tokenized_dataset['train'], tokenizer, batch_size)
eval_dataloader = create_dataloader(tokenized_dataset['validation'], tokenizer, batch_size)




def freeze_model_parameters(model):
    for param in model.parameters():
        param.requires_grad = False

freeze_model_parameters(model) 

your_layer_index = 0  

layer_to_train = model.model.layers[your_layer_index]  
for param in layer_to_train.parameters():
    param.requires_grad = True




train_custom_model(model,
                    num_epochs=3,
                    learning_rate=5e-5,
                    gradient_accumulation_steps=4,
                    train_dataloader=train_dataloader,
                    eval_dataloader=eval_dataloader,
                    device=device)




# BASELINE Loss
# {'eval_loss': 0.7510344982147217, 'eval_runtime': 2602.2609, 'eval_samples_per_second': 2.551, 'eval_steps_per_second': 0.319}
