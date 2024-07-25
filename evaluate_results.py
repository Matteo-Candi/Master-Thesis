from codebleu import calc_codebleu
import re


def reindent_code(code):

    indet_count = 0
    final_code = ''
    for line in code.split(' NEW_LINE '):

        if 'INDENT' in line:
            indet_count += line.count('INDENT')
            line = line.replace('INDENT ', '')
            line = '    ' * indet_count + line

        elif 'DEDENT' in line:
            indet_count -= line.count('DEDENT')
            line = line.replace('DEDENT ', '')
            line = '    ' * indet_count + line

        else:
            line = '    ' * indet_count + line

        final_code += line + '\n'

    return final_code


def format_code(code):

    code = code.replace('( ', '(').replace(' )', ')').replace(' ,', ',').replace(' :', ':'). replace(' . ', '.').replace('[ ', '[').replace(' ]', ']').replace('{ ', '{').replace(' }', '}')
    pattern = r'[a-zA-Z] \('
    code = re.sub(pattern, lambda match: match.group(0).replace(' (', '('), code)
    pattern = r'[a-zA-Z] \['
    code = re.sub(pattern, lambda match: match.group(0).replace(' [', '['), code)

    formatted_code = reindent_code(code)

    return formatted_code


def extract_references(file):

    with open(file, 'r') as file:
        references = file.read()

    references = references.split('\n')
    references = [format_code(reference) for reference in references]

    return references


def extract_predictions(file):

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


def BLUE_score(reference, prediction):

    result = calc_codebleu([reference], [prediction], lang="python", weights=(1, 0, 0, 0), tokenizer=None)

    return result['codebleu']


def CodeBLEU_score(reference, prediction):

    result = calc_codebleu([reference], [prediction], lang="python", weights=(0.25, 0.25, 0.25, 0.25), tokenizer=None)

    return result['codebleu']


def evaluation_metrics(reference, prediction):

    blue = BLUE_score(reference, prediction)
    code_blue = CodeBLEU_score(reference, prediction)

    result_metrics = {
        'BLUE': blue,
        'CodeBLEU': code_blue
    }

    return result_metrics


def evaluate_results(references, predictions):

    results = []

    for reference, prediction in zip(references, predictions):
        reference = format_code(reference)
        prediction = format_code(prediction)
        metrics = evaluation_metrics(reference, prediction)
        results.append(metrics)

    return results


def calculate_mean_scores(references, predictions):

    data = evaluate_results(references, predictions)
    total_blue = 0
    total_codebleu = 0
    count = len(data)

    for entry in data:
        total_blue += entry['BLUE']
        total_codebleu += entry['CodeBLEU']

    mean_blue = total_blue / count
    mean_codebleu = total_codebleu / count

    return {'BLUE': mean_blue, 'CodeBLEU': mean_codebleu}




references = extract_references(r'benchmark\G-TransEval\Python.test')
predictions = extract_predictions('baseline_translation.txt')

results = calculate_mean_scores(references, predictions)
print(results)
