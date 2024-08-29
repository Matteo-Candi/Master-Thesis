import torch
import json
import time
import os

from utils import load_tokenizer, download_model, token_count


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


    # # GENERAL OBSERVATIONS:
    # # num_beam = 5 it takes more than 1.5 hours and it doesn't stop
    # # top_k = 50 (defualt)
    # # top_p = 1 (default)
    # # temperature = 1 (default)


    # # INPUT: max length as the maximum possible and temeperature as low as possible
    # # OUTPUT: file 7 well translated 
    # if step == 1:                                                                              
    #     additional_kwargs = {
    #         "max_length": 65536, 
    #         "num_return_sequences": 1,

    #         "do_sample": True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: reduce output length to avoid loops and add num_beams = 3
    # # OUTPUT: file 7 translation not ended
    # # OBS: seems that num_beams make conlcude the translation prematurely
    # if step == 2:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "num_beams": 3,
    #         "do_sample":True,
    #         "temperature": 0.01,
    #     } 


    # # INPUT: increase num_beams to 5 and early_stopping to True
    # # OUTPUT: file 7 translation not ended
    # # OBS: confrimed that num_beams make conlcude the translation prematurely and even more with early_stopping
    # if step == 3:                                         
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "num_beams": 5,
    #         "do_sample":True,
    #         "early_stopping": True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: adding top_k = 100 levaving temperature as low as possible
    # # OUTPUT: file 7 translation in loop
    # # OBS: top_k seems to make the translation in loop with this temperature
    # if step == 4:                                          
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "top_k": 100,
    #         "do_sample":True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: adding top_p = 0.3
    # # OUTPUT: file 7 translation in loop
    # # OBS: top_p seems to make the translation in loop with this temperature (same as top_k) -> mayb be the temperature influence
    # if step == 5:                                                
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "top_p": 0.3,
    #         "do_sample":True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: retry the step 1 with reduce token to see if the max_length influence the translation
    # # OUTPUT: file 7 in loop
    # # OBS: seems that the max_length influence the translation but maybe is the temperature too low
    # if step == 6:                                         
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: retry with num_beams = 3 and maximum max_length
    # # OUTPUT: file 7 translation is not ended
    # # OBS: num_beams seems to cause the translation to end prematurely as seen before
    # if step == 7:                                
    #     additional_kwargs = {
    #         "max_length": 65536, 

    #         "num_beams": 3,
    #         "do_sample": True,
    #         "temperature": 0.01,
    #     }


    # # INPUT: retry with top_k = 100 and temperature increased to 0.1 with reduced max_length
    # # OUTPUT: file 7 translation not ended
    # # OBS: this combination seems to make the translation not ended
    # if step == 8:                                                
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "top_k": 100,
    #         "do_sample": True,
    #         "temperature": 0.1,
    #     }


    # # INPUT: increase temperature to 0.8
    # # OUTPUT: file 7 translation works
    # # OBS: temperature seems to be the key to make the translation works
    # if step == 9:                                             
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "top_k": 100,
    #         "do_sample": True,
    #         "temperature": 0.8,
    #     }


    # # INPUT: decrease temperature to 0.7 to cehck how much only this parameter influence the translation
    # # OUTPUT: file 7 translation still works
    # # OBS: even this value of tmeprature make it works
    # if step == 10:                                             
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.7,
    #     }


    # # INPUT: decrease temperature to 0.3 to explore the influence of this parameter
    # # OUTPUT: file 7 translation in loop
    # # OBS: this value of temperature seems to be too low
    # if step == 11:                                             
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.3,
    #     }


    # # INPUT: decrease temperature to 0.1 to understand if if was just a case
    # # OUTPUT: file 7 translation in loop
    # # OBS: low values of temperature make the translation in loop
    # if step == 12:                                             
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.1,
    #     }


    # # INPUT: increase temperature to 0.6 to find the threshold
    # # OUTPUT: file 7 translation in loop
    # # OBS: the threshold seeems to be from 0.6 to 0.7 for file 7
    # if step == 13:                                            
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.6,
    #     }


    # # INPUT: increase temperature to 0.8 and test on both files
    # # OUTPUT: file 7 works but 8 in loop
    # # OBS: seems that the value of threshold have to be different based on the input length -> there is not an genral value
    # if step == 14:                                            
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 0.8,
    #     }


    # # INPUT: leaving the temperature as 0.8 and increase top_k to 100 to see if this parameter can help with long inputs
    # # OUTPUT: file 7 works but 8 in loop 
    # # OBS: top_k doesn't seems to help
    # if step == 15:                                          
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "top_k": 100,
    #         "do_sample": True,
    #         "temperature": 0.8,
    #     }


    # # INPUT: increase temperature to 1
    # # OUTPUT: both files works
    # # OBS: temperature seems to be depending on the file input to make the translation works
    # if step == 16:                                            
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 1,
    #     }


    # # INPUT: try top_k = 150 without temperature setted
    # # OUTPUT: file 7 works but 8 seems to be too short
    # # OBS: top_k seems to be a good parameter to make the translation works but reduce the transaltion length too much
    # if step == 17:                                          
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "top_k": 150,
    #     }


    # # INPUT: using a working value for temperature and testing again top_k
    # # OUTPUT: file 7 in loop but stopped by itself ending the translation and code 8 ended but too short
    # # OBS: top_k doesn't seems to help for our case
    # if step == 18:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "top_k": 150,
    #         "temperature": 1,
    #     }


    # # INPUT: testing the influence of top_p
    # # OUTPUT: file 7 translation looks ggod, including also function definition, file 8 in loop
    # # OBS: top_p seems helpful for the quaity of the translation 
    # if step == 19:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "top_p": 0.3,
    #     }


    # # INPUT: testing the influence of low value for top_k with a working temperature value (dafault to 1)
    # # OUTPUT: 7 in loop and 8 ended but not completed (presence of ...)
    # # OBS: top_k doesn't seems to be an helpful parameter for our case
    # if step == 20:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "top_k": 10,
    #         "temperature": 1,
    #     }


    # # INPUT: testing the influence of top_p increasing the temperature
    # # OUTPUT: 7 good but 8 in loop
    # # OBS: top_p bring file_8 to loop behaviour
    # if step == 21:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "top_p": 0.3,
    #         "temperature": 1.3,
    #     }


    # # INPUT: try with increased temperature = 1.3
    # # OUTPUT: file 7 complete but too short, file_8 takes too much time
    # # OBS: 
    # if step == 22:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 1.3,
    #     }

    # # INPUT: try with increased temperature = 1.1
    # # OUTPUT: file 7 translated with a lot of functions, file 8 short translation and incomplete
    # # OBS: 
    # if step == 23:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 1.1,
    #     }


    # # INPUT: new try with temperature default
    # # OUTPUT: 7 is not complete and 8 works
    # # OBS: 
    # if step == 24:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "do_sample": True,
    #         "temperature": 1,
    #     }


    # # INPUT: remove do_sample
    # # OUTPUT: both code too short and not completed
    # # OBS: do sample bring to better results
    # if step == 25:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "temperature": 1,
    #     }

    # # INPUT: new try again
    # # OUTPUT: file 8 good but not completed and file 7 in a loop but ending translation
    # # OBS: the temprature help with the behaviour but there do not help with the completeness of the overall translation
    # if step == 26:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "temperature": 1,
    #         "do_sample": True,
    #     }


    # # INPUT: check the influence of top_p
    # # OUTPUT: file 7 seems complete and file 8 in loop
    # # OBS: 
    # if step == 27:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "temperature": 1,
    #         "do_sample": True,
    #         "top_p": 0.3,
    #     }


    # # INPUT: check the influence of do_sample if is true that help to have a more complete code
    # # OUTPUT: 7 in loop and 8 barely started
    # # OBS: top-p doesn't seems to be too helpful for our use case
    # if step == 28:                                           
    #     additional_kwargs = {
    #         "max_new_tokens": input_tokens * 2,

    #         "temperature": 1,
    #         "do_sample": True,
    #         "top_p": 0.7,
    #     }

    generation_kwargs.update(additional_kwargs)

    # Generate text using the model
    generated_ids = model.generate(
        model_inputs.input_ids,
        **generation_kwargs
    )

    # Decode generated text
    generated_text = tokenizer.batch_decode(generated_ids, skip_special_tokens=True)[0]

    torch.cuda.empty_cache()

    return generated_text




def long_translation_test(model_id, language):

    model = download_model(model_id)
    tokenizer = load_tokenizer(model_id)


    translation_path = f"../long_translations_test/translations_grid_test"
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

    additional_kwargs= {'temperature': 0.9}
    run_single_test(additional_kwargs, language, system_message, model, tokenizer, summary_dict, translation_path, summary_path)


    print('All translations ended!')

    del model
    del tokenizer

    torch.cuda.empty_cache()



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