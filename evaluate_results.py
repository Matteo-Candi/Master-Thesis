import re




def extract_code(file):

    with open(file, 'r') as file:
        data = file.read()
    split_data = data.split('\n\n# END OF TRANSLATION\n\n')[:-1]

    all_list = []

    for translation in split_data:
        if '```python' in translation:
            psttern = r'```python\n(.*?)```'
            match = re.findall(psttern, translation, re.DOTALL)[0]
            all_list.append(match)
        else:
            translated_function = 'def ' + translation.split('def ')[1]
            cleaned_translation = translated_function.split('#')[0]
            all_list.append(cleaned_translation)

    return all_list



