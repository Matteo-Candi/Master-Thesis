from itertools import takewhile
import json
import re
import os

from unit_tests.json_to_unittest import json_to_test_lines


# Function to replace the function name in the provided code
def replace_func_name(code: str) -> str:
    
    # Regular expression pattern to match the function definition
    pattern: str = r'def\s+(\w+)\('
    match = re.search(pattern, code)
    original_name = match.group(1)
    new_name: str = 'testfunc'

    # Replace the original function name with 'testfunc'
    code = code.replace(original_name + '(', new_name + '(')

    return code


# Function to add a new function to the test file
def add_function(idx: int, prediction: str, function_name: str) -> None:

    formatted_idx: str = ''
    # Format the index with leading zeros
    if idx < 10:
        formatted_idx = '00' + str(idx)
    elif idx < 100:
        formatted_idx = '0' + str(idx)
    else:
        formatted_idx = str(idx)

    # Define the test folder and template file path
    test_folder: str = f"unit_tests/test_files/{formatted_idx}_{function_name}"
    template_file: str = 'unit_tests/template.py'
    os.makedirs(test_folder, exist_ok=True)

    file_lines: list[str] = []
    with open(template_file, "r", encoding="utf-8") as f:
        lines: list[str] = f.readlines()
        for line in lines:
            file_lines.append(line)

    before: bool = True
    after: bool = False
    test_file_lines_before: list[str] = []
    test_file_lines_after: list[str] = []

    indent_space_num: int = 0

    # Split the template file into parts before and after the target function insertion point
    for line in file_lines:
        if before:
            test_file_lines_before.append(line)
        s_line: str = line.strip()
        if s_line.startswith("# Write the target function here"):
            before = False
            indent_space_num = len(list(takewhile(str.isspace, line)))
        if not before and s_line.startswith("# End here"):
            after = True
        if after:
            test_file_lines_after.append(line)

    test_file_lines: list[str] = []
    for line in test_file_lines_before:
        test_file_lines.append(line)

    # Replace the function name in the prediction code
    code: str = replace_func_name(prediction)

    # Insert the modified prediction code into the test file
    test_file_lines.append(" " * indent_space_num + code + "\n")

    for line in test_file_lines_after:
        test_file_lines.append(line)

    # Write the modified test file
    with open(test_folder + '/test.py', "w", encoding="utf-8") as f:
        for line in test_file_lines:
            f.write(line)

    return


# Function to add unit tests to the test file
def add_tests(idx: int, question: str, function_name: str) -> None:

    formatted_idx: str = ''

    # Format the index with leading zeros
    if idx < 10:
        formatted_idx = '00' + str(idx)
    elif idx < 100:
        formatted_idx = '0' + str(idx)
    else:
        formatted_idx = str(idx)

    # Define the test folder and template file path
    test_folder: str = f"unit_tests/test_files/{formatted_idx}_{function_name}"
    template_file: str = f'unit_tests/test_files/{formatted_idx}_{function_name}/test.py'

    file_lines: list[str] = []
    with open(template_file, "r", encoding="utf-8") as f:
        lines = f.readlines()
        for line in lines:
            file_lines.append(line)

    before: bool = True
    after: bool = False
    test_file_lines_before: list[str] = []
    test_file_lines_after: list[str] = []

    indent_space_num: int = 0

    # Split the template file into parts before and after the unit tests insertion point
    for line in file_lines:
        if before:
            test_file_lines_before.append(line)
        s_line = line.strip()
        if s_line.startswith("# Write the unit tests here"):
            before = False
            indent_space_num = len(list(takewhile(str.isspace, line)))
        if not before and s_line.startswith("# End here"):
            after = True
        if after:
            test_file_lines_after.append(line)

    test_file_lines: list[str] = []
    for line in test_file_lines_before:
        test_file_lines.append(line)

    # Convert JSON test cases to test lines
    tests_lines = json_to_test_lines(question, 'python')
    for line in tests_lines:
        test_file_lines.append(" " * indent_space_num + line)

    for line in test_file_lines_after:
        test_file_lines.append(line)

    # Write the modified test file
    with open(template_file, "w", encoding="utf-8") as f:
        for line in test_file_lines:
            f.write(line)
        print("Test file generated: " + test_folder)


# Main function to generate unit tests
def unit_tests_generator(test_values_filename: str, predictions: list[str]) -> None:

    # Load the test values from the JSON file
    with open(test_values_filename, 'r') as file:
        questions = json.load(file)

    # Iterate over each question and corresponding prediction
    for i, question in enumerate(questions['questions']):
        add_function(i+1, predictions[i], question['name'])
        add_tests(i+1, question, question['name'])

    print("\nAll test files generated!\n")

    return