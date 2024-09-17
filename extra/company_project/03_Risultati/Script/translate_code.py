from transformers import AutoTokenizer, AutoModelForCausalLM
import ollama
import signal
import torch
import time
import json
import os



def download_model(model_id, quantization):

    if quantization == 16:
        model = AutoModelForCausalLM.from_pretrained(model_id, torch_dtype=torch.float16, device_map = 'cuda')

    model.eval()

    return model



def load_tokenizer(model_id):

    tokenizer = AutoTokenizer.from_pretrained(model_id)

    return tokenizer



def load_model_q16(model_name):

    folder_extension = "Q16"
    torch_type = torch.float16
    model_path = f"models/{model_name}/{folder_extension}"

    model = AutoModelForCausalLM.from_pretrained(model_path, device_map = 'cuda', torch_dtype=torch_type, attn_implementation="flash_attention_2")

    model.eval()

    return model



def generate_request_structure(model_name, prompt, tokenizer, language, version, step, apply_template=True):

    with open(f"prompts/prompts_{step}/prompt_{language}_v{version}.txt", 'r') as file:
        system_message = file.read()

    if language == 'sas':
        input_language = 'SAS'
        output_language = 'Python'
    elif language == 'sql':
        input_language = 'SQL'
        output_language = 'PySpark'


    request = f"Translate the following code from {input_language} to {output_language}:\n{prompt}"

    if model_name == "CodeQwen1.5-7B-Chat":
        text = [
            {"role": "system", "content": system_message},
            {"role": "user", "content": request}]
        if apply_template:
            text = tokenizer.apply_chat_template(text, tokenize=False, add_generation_prompt=True)


    elif model_name in ["OpenCodeInterpreter-DS-6.7B", "OpenCodeInterpreter-DS-33B", "deepseek-coder-33b-instruct"]:
        text = [{'role': 'user', 'content': system_message + '\n' + request }]
        if apply_template:
            text = tokenizer.apply_chat_template(text, tokenize=False, add_generation_prompt=True)


    elif model_name == "Magicoder-S-DS-6.7B":

        text = f'''{system_message} \n\n@@Instruction \n{request} \n@@Response'''


    elif model_name == "Artigenz-Coder-DS-6.7B":

        text = f'''{system_message} \n\n@@Instruction \n{request} \n@@Response'''


    return text



def get_ollama_model_name(model_name, quantization):

    i_model = int(quantization / 4) - 1

    ollama_models = {"OpenCodeInterpreter-DS-33B": ['pxlksr/opencodeinterpreter-ds:33b-Q4_K_M', None],
                        "deepseek-coder-33b-instruct": ['deepseek-coder:33b-instruct-q4_K_M', None],
                        "OpenCodeInterpreter-DS-6.7B": ['pxlksr/opencodeinterpreter-ds:6.7b-Q4_K_M', 'wojtek/opencodeinterpreter:6.7b-ds-q8_0'],
                        "CodeQwen1.5-7B-Chat": ['codeqwen:7b-chat-v1.5-q4_1', 'codeqwen:7b-chat-v1.5-q8_0'],
                        "Magicoder-S-DS-6.7B": ['mithun/magicoder:6.7B-S-DS-Q4_K_M', 'mithun/magicoder:6.7B-S-DS-Q8_0'],
                        "Artigenz-Coder-DS-6.7B": [None, None],
                        }
    
    ollama_model_name = ollama_models[model_name][i_model]

    return ollama_model_name



def dowload_ollama_model_name(model_name, quantization):

    ollama_model_name = get_ollama_model_name(model_name, quantization)

    if ollama_model_name is None:
        print("Model not available for this quantization")

    print(f"Loading model from Ollama... ({ollama_model_name})")
    ollama.pull(ollama_model_name)

    return ollama_model_name



class TimeoutException(Exception):
    pass

def timeout_handler(signum, frame):
    raise TimeoutException

def generate_translation(model, tokenizer, prompt, max_length, model_name, temperature=1, language='sas', step=1, version=2):

    def generate_text():
        text = generate_request_structure(model_name, prompt, tokenizer, language, version, step)

        # Tokenize the text
        model_inputs = tokenizer([text], return_tensors="pt").to('cuda')

        # Generate text using the model
        generated_ids = model.generate(
            model_inputs.input_ids,
            attention_mask=model_inputs.attention_mask,
            pad_token_id=tokenizer.eos_token_id,
            max_length=max_length,
            num_return_sequences=1,
            do_sample=True,
            temperature=temperature,
        )

        generation_kwargs = {
            "max_length": max_length, 
            "attention_mask": model_inputs.attention_mask,
            "pad_token_id": tokenizer.eos_token_id,
            "num_return_sequences": 1,
            "do_sample": True,
            "temperature": temperature,
        }

        # Generate text using the model
        generated_ids = model.generate(
            model_inputs.input_ids,
            **generation_kwargs
        )

        # Decode generated text
        generated_text = tokenizer.batch_decode(generated_ids, skip_special_tokens=True)[0]

        torch.cuda.empty_cache()

        return generated_text

    if step != 1:
        # Set the signal handler and a 15-minute alarm
        signal.signal(signal.SIGALRM, timeout_handler)
        signal.alarm(900)  # 900 seconds = 15 minutes

    try:
        result = generate_text()
    except TimeoutException:
        return 'TimeoutError: The model took too long to generate a response. Please try again.'
    finally:
        if step != 1:
            signal.alarm(0)  # Disable the alarm

    return result


def generate_translation_ollama(ollama_model_name, tokenizer, prompt, max_length, model_name, temperature=1, language='sas', step=1, version = 2):
    
    text = generate_request_structure(model_name, prompt, tokenizer, language, version, step, apply_template=False)
 
    opts = {"num_ctx": max_length, "temperature": temperature}

    generated_text = ollama.chat(model=ollama_model_name, messages=text, options=opts)['message']['content']

    torch.cuda.empty_cache()

    return generated_text


def token_count(prompt, tokenizer):

    model_inputs = tokenizer([prompt], return_tensors="pt")
    tot_input_tokens =  model_inputs.input_ids.shape[1]

    return tot_input_tokens



def translation_tests(model_id, quantization, language, version=2, step=1, load_from_local=False, files=None):

    model_name = model_id.split('/')[1] 

    tokenizer = load_tokenizer(model_id)  

    if load_from_local:
        model = load_model_q16(model_name)

    if quantization in [4, 8]:
        model = None
        ollama_model_name = dowload_ollama_model_name(model_name, quantization)

    else:
        model = download_model(model_id, quantization)


    summary_path = f"{language}_files/translations_{step}/summary_{language}.json"
    os.makedirs(os.path.dirname(summary_path), exist_ok=True)

    try:
        with open(summary_path, "r") as file:
            summary_dict = json.load(file)
    except FileNotFoundError:
        summary_dict = {}
        with open(summary_path, "w") as file:
            json.dump(summary_dict, file)


    with open(f"prompts/prompts_{step}/prompt_{language}_v{version}.txt", 'r') as file:
        system_message = file.read()

    print(f"\nCurrent model: {model_name} \nQuantization: {quantization} \nVersion: {version}\nStep: {step}\n")

    if language == 'sas':
        n_files = 7
    elif language == 'sql':
        n_files = 6

    files_list = range(1, n_files+1)

    if files is not None:
        files_list = files

    for i in files_list:

        current_file = f"file_{i}.{language}"

        print(f"Current translation: {current_file}")

        with open(f"{language}_files/{current_file}") as file:
            prompt = file.read()

        max_model_tokens = 16384
        if model_name == 'CodeQwen1.5-7B-Chat':
            max_model_tokens = 65536

        input_tokens = token_count(prompt, tokenizer) + token_count(system_message, tokenizer)

        if step in [1,3]:
            max_length_token = input_tokens * 4
            if max_model_tokens < max_length_token:
                max_length_token = max_model_tokens
        else:
            max_length_token = max_model_tokens

        if quantization in [4, 8]:
            timer_start = time.time()
            response = generate_translation_ollama(ollama_model_name, tokenizer, prompt, max_length=max_length_token, model_name=model_name, language=language, version=version, step=step)
            time_required = round(time.time() - timer_start, 2)

        elif quantization in [16, 32]:
            timer_start = time.time()
            response = generate_translation(model, tokenizer, prompt, max_length=max_length_token, model_name=model_name, language=language, version=version, step=step)
            time_required = round(time.time() - timer_start, 2)

        translation_path = f"{language}_files/translations_{step}/{model_name}/Q{quantization}"
        os.makedirs(translation_path, exist_ok=True)
        
        with open(f"{translation_path}/file_{i}_v{version}.txt", "w") as file:
            file.write(response)

        output_tokens = token_count(response, tokenizer)

        current_dict = {f"{model_name}_Q{quantization}_file_{i}_v{version}":
                                    {'input_tokens': input_tokens,
                                    'max_length': max_length_token,
                                    'time': time_required,
                                    'output_tokens': output_tokens}}

        print(current_dict, "\n")
        
        summary_dict.update(current_dict)
        

        with open(f"{language}_files/translations_{step}/summary_{language}.json", "w") as file:
            json.dump(summary_dict, file)

    print('All translations ended!')

    del model
    del tokenizer

    torch.cuda.empty_cache()

