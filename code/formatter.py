import re
import os


# Function to reindent the code based on INDENT and DEDENT markers
def reindent_code(code: str) -> str:
    indet_count: int = 0
    final_code: str = ''

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


# Function to reformat the reference code by removing extra spaces
def reformat_reference_code(code: str) -> str:
    code = code.replace('( ', '(').replace(' )', ')').replace(' ,', ',').replace(' :', ':').replace(' . ', '.').replace('[ ', '[').replace(' ]', ']').replace('{ ', '{').replace(' }', '}')
    
    round_braket_pattern: str = r'[a-zA-Z] \('
    code = re.sub(round_braket_pattern, lambda match: match.group(0).replace(' (', '('), code)
    
    square_braket_pattern: str = r'[a-zA-Z] \['
    code = re.sub(square_braket_pattern, lambda match: match.group(0).replace(' [', '['), code)

    formatted_code: str = reindent_code(code)

    return formatted_code


# Function to extract and reformat references from a file
def extract_references(filename: str) -> list[str]:
    with open(filename, 'r') as file:
        references: str = file.read()
    splitted_references: list[str] = references.split('\n')
    reformat_references = [reformat_reference_code(reference) for reference in splitted_references]
    with open('../benchmark/Python_formatted.py', 'w') as file:
        for i, item in enumerate(references):
            file.write(f"# {i+1} \n{item.strip()}\n\n")
    return reformat_references


# Function to extract and reformat predictions from a file
def extract_predictions(filename: str) -> list[str]:
    file_path: str = '../predictions/' + filename + '.txt'

    with open(file_path, 'r') as file:
        data: str = file.read()

    splitted_data: list[str] = data.split(('\n\n# END OF TRANSLATION\n\n'))
    all_list: list[str] = []
    py_pattern: str = '```python\n(.*?)```'

    for el in splitted_data:
        if '```python' in el:
            match = re.findall(py_pattern, el, re.DOTALL)[0]
            all_list.append(match)
        else:
            comment_pattern: str = r'\n\n[^ ]'
            if re.search(comment_pattern, el):
                new_line_split_el: str = el.split('\n\n')[0]
                all_list.append(new_line_split_el)
            else:
                hash_split_el: str = el.split('#')[0]
                all_list.append(hash_split_el)
                
    input_file_name = os.path.basename(file.name).split('.')[0]
    output_file: str = f"../results/{input_file_name}/{input_file_name}_formatted.py"

    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w') as file:
        for i, item in enumerate(all_list):
            file.write(f"# {i+1} \n{item.strip()}\n\n")

    return all_list