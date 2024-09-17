from generate_long_translation import long_translation_test
from generate_streaming_translation import streaming_mode_test
from generate_commented_translation import comment_and_translate_test
from check_translation_completeness import check_completeness_test

from transformers import TRANSFORMERS_CACHE
import shutil



def main():

    model = "Qwen/CodeQwen1.5-7B-Chat"
    language = 'sas'
    
    # long_translation_test(model, language) 
    # streaming_mode_test(model, language)
    comment_and_translate_test(model, language)

    # shutil.rmtree(TRANSFORMERS_CACHE)



if __name__ == "__main__":

    main()