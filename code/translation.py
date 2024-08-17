from transformers import AutoTokenizer, AutoModelForCausalLM
from fvcore.nn import FlopCountAnalysis, parameter_count
from tqdm import tqdm
import torch
import json
import sys
import os

from NOSE import model_reduction
from training.utils import get_idxs_list_NOSE, reload_checkpoint
from training.model_shrink import customize_model



# Function to extract data from a file
def extract_data(file_path: str):
    data = []
    with open(file_path, "r") as file:
        for line in file:
            data.append(line.strip())

    return data


# Function to save translations to a file
def save_translations(translations, file_path: str) -> None:
    file_path += '.txt'
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, 'w') as file:
        for item in translations:
            file.write(f"{item}\n\n# END OF TRANSLATION\n\n")

    return


# Function to save computation metrics to a JSON file
def save_computation_metrics(file_name: str, model, device: str) -> None:
    gpu_storage = torch.cuda.memory_allocated(device)
    input_ids = torch.randint(0, 1000, (1, 1024)).to(device)
    flops = FlopCountAnalysis(model, (input_ids,))

    print(f"\nComputational metrics: FLOPs: {flops.total() / 10**9} B, Parameters: {parameter_count(model)[''] / 10**9} B, Memory: {gpu_storage / 1024**3} GB\n")

    computational_metrics: dict = {
        'flops': flops.total(),
        'parameters': parameter_count(model)[''],
        'memory': gpu_storage
    }

    output_file: str = f"../results/{file_name}/metrics.json"
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w') as file:
        json.dump(computational_metrics, file)

    return



# Main function to generate translations from Java to Python
def generate_translations(input_data_path: str, file_name: str) -> None:
    model_id: str = "m-a-p/OpenCodeInterpreter-DS-6.7B"
    data = extract_data(input_data_path)
    device: str = 'cuda'

    tokenizer = AutoTokenizer.from_pretrained(model_id)
    model = AutoModelForCausalLM.from_pretrained(model_id, device_map=device, torch_dtype=torch.float16)

    if file_name != "baseline":
        step = int(file_name.split('_')[-1])
        S = get_idxs_list_NOSE(step)
        checkpoint_path = f"training/results_and_checkpoints/nose_step_{step}/final_checkpoint.pth"
        model_reduction(model, S)
        # customize_model(model, S, 0)
        _, _, _ = reload_checkpoint(checkpoint_path, model, S, None, None, device, test_phase=True)


    model.to(device)
    model.eval()

    save_computation_metrics(file_name, model, device)

    translations = []

    prompt: str = "Convert the following code from Java to Python without testing it:"

    for code in tqdm(data):
        inputs: list = [{'role': 'user', 'content': prompt + '\n' + code}]
        inputs = tokenizer.apply_chat_template(inputs, return_tensors="pt").to(model.device)

        output = model(inputs)

        output = model.generate(
            inputs,
            max_length=1000,
            do_sample=True,
            temperature=0.01,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
            use_cache = False,
            past_key_values=None
        )

        decoded_output = tokenizer.decode(output[0][len(inputs[0]):], skip_special_tokens=True)
        translations.append(decoded_output)

        torch.cuda.empty_cache()

    save_translations(translations, f'../results/{file_name}/predictions')

    print("\nTranslations saved to predictions folder\n")

    return