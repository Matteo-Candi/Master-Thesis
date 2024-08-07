from transformers import AutoTokenizer, AutoModelForCausalLM
from fvcore.nn import FlopCountAnalysis, parameter_count
from tqdm import tqdm
import torch
import json
import os

# Function to extract data from a file
def extract_data(file_path):
    data = []
    with open(file_path, "r") as file:
        for line in file:
            data.append(line.strip())
    return data

# Function to save translations to a file
def save_translations(translations, file_path):
    file_path = file_path + '.txt'
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, 'w') as file:
        for item in translations:
            file.write(f"{item}\n\n# END OF TRANSLATION\n\n")

# Function to save computation metrics to a JSON file
def save_computation_metrics(file_name, model, device):
    gpu_storage = torch.cuda.memory_allocated(device)
    input_ids = torch.randint(0, 1000, (1, 1024)).to(device)
    flops = FlopCountAnalysis(model, (input_ids,))

    print(f"\nComputational metrics: FLOPs: {flops.total() / 10**9} B, Parameters: {parameter_count(model)[''] / 10**9} B, Memory: {gpu_storage / 1024**3} GB\n")

    computational_metrics = {
        'flops': flops.total(),
        'parameters': parameter_count(model)[''],
        'memory': gpu_storage
    }

    output_file = f"../results/{file_name}/metrics.json"
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w') as file:
        json.dump(computational_metrics, file)

# Main function to generate translations from Java to Python
def generate_translations(input_data_path, file_name):
    model_id = "m-a-p/OpenCodeInterpreter-DS-6.7B"
    data = extract_data(input_data_path)
    device = 'cuda'

    tokenizer = AutoTokenizer.from_pretrained(model_id)
    model = AutoModelForCausalLM.from_pretrained(model_id, device_map=device, torch_dtype=torch.float16)
    model.eval()

    save_computation_metrics(file_name, model, device)

    translations = []

    prompt = "Convert the following code from Java to Python without testing it:"

    for code in tqdm(data):
        input = [{'role': 'user', 'content': prompt + '\n' + code}]
        input = tokenizer.apply_chat_template(input, return_tensors="pt").to(model.device)

        output = model.generate(
            input,
            max_length=1000,
            do_sample=True,
            temperature=0.01,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )

        decoded_output = tokenizer.decode(output[0][len(input[0]):], skip_special_tokens=True)
        translations.append(decoded_output)

        torch.cuda.empty_cache()

    save_translations(translations, f'../predictions/{file_name}')

    print("\nTranslations saved to predictions folder\n")

    return