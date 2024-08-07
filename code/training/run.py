from transformers import AutoTokenizer, AutoModelForCausalLM
import torch.nn as nn
import pandas as pd


# tokenizer = AutoTokenizer.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B")
# pretrained_model = AutoModelForCausalLM.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B").to('cuda')


# dataset = pd.read_json("hf://datasets/m-a-p/Code-Feedback/Code-Feedback.jsonl", lines=True)

# def preprocess_function(examples):
#     return tokenizer(examples["content"], padding="max_length", truncation=True, return_tensors="pt")

# tokenized_datasets = dataset.map(preprocess_function, batched=True)



from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer, DataCollatorForLanguageModeling
from datasets import load_dataset

# Load pre-trained model and tokenizer
model_name = "m-a-p/OpenCodeInterpreter-DS-6.7B"
model = AutoModelForCausalLM.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

# Load and preprocess the dataset
dataset = load_dataset("m-a-p/Code-Feedback")

def tokenize_function(examples):
    return tokenizer(examples['text'], padding="max_length", truncation=True)

tokenized_datasets = dataset.map(tokenize_function, batched=True)

# Set up training arguments
training_args = TrainingArguments(
    output_dir="./results",
    evaluation_strategy="epoch",
    learning_rate=2e-5,
    per_device_train_batch_size=32,
    per_device_eval_batch_size=32,
    num_train_epochs=1,
    weight_decay=0.01,
    logging_dir='./logs',
)

# Define the data collator
data_collator = DataCollatorForLanguageModeling(
    tokenizer=tokenizer,
    mlm=False,
)

# Initialize the Trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized_datasets['train'],
    eval_dataset=tokenized_datasets['validation'],
    data_collator=data_collator,
)

# Train the model
trainer.train()

# Save the model and tokenizer
model.save_pretrained("./fine-tuned-model")
tokenizer.save_pretrained("./fine-tuned-model")
