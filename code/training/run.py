import argparse

from transformers import AutoModelForCausalLM, AutoTokenizer
from datasets import DatasetDict
import torch

from utils import tokenize_and_save_dataset, create_dataloader, train_custom_model, validation_step, get_idxs_list_NOSE
from model_shrink import customize_model




if __name__ == "__main__":

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

    # validation_step(model, val_dataloader, device)


    train_custom_model(model,
                        S,
                        num_epochs=5,
                        learning_rate=5e-6,
                        gradient_accumulation_steps=16,
                        train_dataloader=train_dataloader,
                        val_dataloader=val_dataloader,
                        device=device,
                        nose_step=args.nose_step
                        )







# Traceback (most recent call last):
#   File "run.py", line 49, in <module>
#     train_custom_model(model,
#   File "/home/federicaverna/thesis/code/training/utils.py", line 128, in train_custom_model
#     loss.backward()
#   File "/home/federicaverna/thesis/thesis_env/lib/python3.8/site-packages/torch/_tensor.py", line 525, in backward
#     torch.autograd.backward(
#   File "/home/federicaverna/thesis/thesis_env/lib/python3.8/site-packages/torch/autograd/__init__.py", line 267, in backward
#     _engine_run_backward(
#   File "/home/federicaverna/thesis/thesis_env/lib/python3.8/site-packages/torch/autograd/graph.py", line 744, in _engine_run_backward
#     return Variable._execution_engine.run_backward(  # Calls into the C++ engine to run the backward pass
# torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 1.57 GiB. GPU 



# BASELINE Loss
# {'val_loss': 0.8106189448610845}

# RERUN VALIDATION BASELINE
