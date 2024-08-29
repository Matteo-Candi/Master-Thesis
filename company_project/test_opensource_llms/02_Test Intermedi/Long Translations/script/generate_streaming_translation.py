from utils import load_tokenizer, download_model, token_count
from transformers import TextStreamer
import torch
import time
import json
import os


def generate_translation(model, tokenizer, system_message, prompt, additional_kwargs):

    text = [
            {"role": "system", "content": system_message},
            {"role": "user", "content": prompt}]
    text = tokenizer.apply_chat_template(text, tokenize=False, add_generation_prompt=True)

    # Tokenize the text
    model_inputs = tokenizer([text], return_tensors="pt").to('cuda')

    # Define generation kwargs
    generation_kwargs = {
            "attention_mask": model_inputs.attention_mask,
            "pad_token_id": tokenizer.eos_token_id,
    }


    generation_kwargs.update(additional_kwargs)
    streamer = TextStreamer(tokenizer, skip_prompt=True, skip_special_tokens=True)

    # Generate text using the model
    generated_ids = model.generate(
        model_inputs.input_ids,
        streamer=streamer,
        **generation_kwargs
    )

    # Decode generated text
    generated_text = tokenizer.batch_decode(generated_ids, skip_special_tokens=True)[0]

    torch.cuda.empty_cache()

    return generated_text



def run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path):

    for i in [6, 7, 8]:

        current_file = f"file_{i}.{language}"
        if len(additional_kwargs) == 0:
            file_name = f"file_{i}_default.txt"
        else:
            file_name = f"file_{i}_{list(additional_kwargs.keys())[0]}_{list(additional_kwargs.values())[0]}.txt"

        print(f"\nCurrent translation: {current_file}")
        print(f"{file_name}")

        with open(f"../{language}_files/{current_file}") as file:
            prompt = file.read()

        input_tokens = token_count(system_message, tokenizer) + token_count(prompt, tokenizer)

        base_kwargs = {
                "max_new_tokens": input_tokens * 2, 
                "do_sample": True,
        }

        additional_kwargs.update(base_kwargs)

        timer_start = time.time()
        response = generate_translation(model, tokenizer, system_message, prompt, additional_kwargs)
        time_required = round(time.time() - timer_start, 2)

        additional_kwargs = {}

        os.makedirs(translation_path, exist_ok=True)
        
        with open(f"{translation_path}/{file_name}", "w") as file:
            file.write(response)


        output_tokens = token_count(response, tokenizer) - input_tokens

        current_dict = {f"{file_name}.txt":
                            {'input_tokens': input_tokens,
                            'time': time_required,
                            'output_tokens': output_tokens}}
        
        print(current_dict, "\n")

        summary_dict.update(current_dict)

        with open(summary_path, "w") as file:
            json.dump(summary_dict, file)



def streaming_mode_test(model_id, language):

    model = download_model(model_id)
    tokenizer = load_tokenizer(model_id)


    translation_path = f"../long_translations_test/translations_streaming"
    summary_path = f"{translation_path}/summary.json"
    os.makedirs(os.path.dirname(summary_path), exist_ok=True)

    try:
        with open(summary_path, "r") as file:
            summary_dict = json.load(file)
    except FileNotFoundError:
        summary_dict = {}
        with open(summary_path, "w") as file:
            json.dump(summary_dict, file)


    prompt_path = f"../long_translations_test/prompt.txt"
    with open(prompt_path, 'r') as file:
        system_message = file.read()


    temperature = [0.7, 0.8, 1, 1.2]
    top_k = [10, 50]
    top_p = [0.1, 0.4, 0.7]
    params_list = [temperature, top_k, top_p]  

    # for j in range(len(params_list)):
    #     if j==0:
    #         for t in temperature:
    #             additional_kwargs= {"temperature": t}
    #             run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path)
    #     elif j==1:
    #         for k in top_k:
    #             additional_kwargs= {"top_k": k}
    #             run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path)
    #     elif j==2:
    #         for p in top_p:
    #             additional_kwargs= {"top_p": p}
    #             run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path)

    additional_kwargs= {}
    run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path)


    print('All translations ended!')

    del model
    del tokenizer

    torch.cuda.empty_cache()