from translate_code import translation_tests, get_ollama_model_name

from transformers import TRANSFORMERS_CACHE
import shutil
import ollama



def main():

    model_1 = "Qwen/CodeQwen1.5-7B-Chat"
    model_2 = "m-a-p/OpenCodeInterpreter-DS-6.7B"
    model_3 = "Artigenz/Artigenz-Coder-DS-6.7B"
    model_4 = "ise-uiuc/Magicoder-S-DS-6.7B"
    model_5 = "deepseek-ai/deepseek-coder-33b-instruct" # use small quantization
    model_6 = "m-a-p/OpenCodeInterpreter-DS-33B"        # use small quantization

    models = [model_1, model_2, model_3, model_4, model_5, model_6]
    models = [model_3, model_4, model_5, model_6]

    step = 3

    for model in models:
        q = 16
        if model in [model_5, model_6]: 
            q = 4

        translation_tests(model, quantization = q, language = 'sas', version=1, step=step) 
        translation_tests(model, quantization = q, language = 'sas', version=2, step=step) 
        translation_tests(model, quantization = q, language = 'sql', version=1, step=step) 
        translation_tests(model, quantization = q, language = 'sql', version=2, step=step) 


        # translation_tests(model, quantization = q, language = 'sql', version=1, step=2) 
        # translation_tests(model, quantization = q, language = 'sql', version=2, step=2)

        if model in [model_5, model_6]:
            model_name = model.split('/')[1]
            ollama_model_name = get_ollama_model_name(model_name, q)
            ollama.delete(ollama_model_name)
        elif model != model_1:
            shutil.rmtree(TRANSFORMERS_CACHE)



if __name__ == "__main__":

    main()
