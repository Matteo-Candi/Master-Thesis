from transformers import AutoTokenizer, AutoModelForCausalLM

def extract_data(file_path):
    data = []
    with open(file_path, "r") as file:
        for line in file:
            data.append(line.strip())
    return data


def save_translations(translations, filename):
    with open(f'{filename}.txt', 'w') as file:
        for item in translations:
            file.write(f"{item}\n")


def generate_translations(data):

    model_id = "m-a-p/OpenCodeInterpreter-DS-6.7B"

    tokenizer = AutoTokenizer.from_pretrained(model_id)
    model = AutoModelForCausalLM.from_pretrained(model_id, device_map="cuda")
    model.eval()

    translations = []

    prompt = "Convert the following code from Java to Python:"

    for code in data:
        input = [{'role': 'user', 'content': prompt + '\n' + code }]
        input = tokenizer.apply_chat_template(input, return_tensors="pt").to(model.device)

        output = model.generate(
            input, 
            do_sample=False,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )

        decoded_output = tokenizer.decode(output[0][len(input[0]):], skip_special_tokens=True)
        translations.append(decoded_output)

    save_translations(translations, 'translations_baseline')




java_data_path = r'benchmark\G-TransEval\Java.test' 

java_data = extract_data(java_data_path)

generate_translations(java_data)
