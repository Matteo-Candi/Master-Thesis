from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
import ollama
import signal
import torch
import time
import json
import os



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




def summarize_code(model, file):

    print('Summarizing...')

    with open(file, 'r') as f:
        code = f.read()

    system_message = f'''Describe one by line the code, including all the values, all the variables names, all the path, everything. nothing have to miss.
			I have to be able to reproduce the exact code again from this description'''
    text = [{'role': 'user', 'content': system_message + '\n' + code }]

    summmary = generate_summary(text, model)

    return summmary


def generate_summary(text, model):

    opts = {"num_ctx": 16348, "temperature": 0.5}

    generated_text = ollama.chat(model=model, messages=text, options=opts)['message']['content']

    torch.cuda.empty_cache()

    return generated_text



def generate_translation_ollama(ollama_model_name, summary, max_length=16348, temperature=0.5):

    print('Translating...')
 
    opts = {"num_ctx": max_length, "temperature": temperature}
    system_message = f'''Generate Python code from this text following exaclty the definitions and instructions:'''
    text = [{'role': 'user', 'content': system_message + '\n' + summary }]

    generated_text = ollama.chat(model=ollama_model_name, messages=text, options=opts)['message']['content']

    torch.cuda.empty_cache()

    return generated_text





def test(model_name, file):

    ollama_model_name = dowload_ollama_model_name(model_name, 4)

    summary = summarize_code(ollama_model_name, file)

    with open('summary.txt', 'w') as f:
        f.write(summary)


    translation = generate_translation_ollama(ollama_model_name, summary) 

    with open('translation.py', 'w') as f:
        f.write(translation)
