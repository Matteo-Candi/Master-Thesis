import re
import os



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


def reformat_reference_code(code):

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
    references = [reformat_reference_code(reference) for reference in references]

    with open('../benchmark/Python_formatted.py', 'w') as file:
        for i, item in enumerate(references):
            file.write(f"# {i+1} \n{item.strip()}\n\n")

    return references


def extract_predictions(file):

    file_path = '../results/' + file + '/predictions.txt'

    with open(file_path, 'r') as file:
        data = file.read()

    data = data.split(('\n\n# END OF TRANSLATION\n\n'))

    all_list = []

    py_pattern = '```python\n(.*?)```'

    for el in data:
        if '```python' in el:
            match = re.findall(py_pattern, el, re.DOTALL)[0]
            all_list.append(match)
        else:
            comment_pattern = r'\n\n[^ ]'

            if re.search(comment_pattern, el):
                while el[:3] != 'def':
                    el = "\n".join(el.split('\n')[1:])
                el = el.split('\n\n')[0]
                all_list.append(el)
        
            else:
                el = el.split('#')[0]
                all_list.append(el)

    input_file_name = os.path.basename(file.name).split('.')[0]
    output_file= f"../results/{input_file_name}/predictions_formatted.py"

    os.makedirs(os.path.dirname(output_file), exist_ok=True)

    with open(output_file, 'w') as file:
        for i, item in enumerate(all_list):
            file.write(f"# {i+1} \n{item.strip()}\n\n")

    return all_list
