from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

def load_tokenizer(model_id):
    tokenizer = AutoTokenizer.from_pretrained(model_id)

    return tokenizer


def download_model(model_id):
    model = AutoModelForCausalLM.from_pretrained(model_id, torch_dtype=torch.float16, device_map = 'cuda')
    model.eval()

    return model


def token_count(prompt, tokenizer):
    model_inputs = tokenizer([prompt], return_tensors="pt")
    tot_input_tokens =  model_inputs.input_ids.shape[1]

    return tot_input_tokens