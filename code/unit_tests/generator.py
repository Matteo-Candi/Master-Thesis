from itertools import takewhile
import json
import re
import os

from unit_tests.json_to_unittest import json_to_test_lines

# Function to replace the function name in the provided code
def replace_func_name(code):
    
    # Regular expression pattern to match the function definition
    pattern = r'def\s+(\w+)\('
    match = re.search(pattern, code)
    if match is not None:
        original_name = match.group(1)
        new_name = 'testfunc'

        # Replace the original function name with 'testfunc'
        code = code.replace(original_name + '(', new_name + '(')
    return code

# Function to add a new function to the test file
def add_function(idx, prediction, function_name):
    # Format the index with leading zeros
    if idx < 10:
        idx = '00' + str(idx)
    elif idx < 100:
        idx = '0' + str(idx)
    else:
        idx = str(idx)

    # Define the test folder and template file path
    test_folder = f"unit_tests/test_files/{idx}_{function_name}"
    template_file = 'unit_tests/template.py'
    os.makedirs(test_folder, exist_ok=True)

    file_lines = []
    with open(template_file, "r", encoding="utf-8") as f:
        lines = f.readlines()
        for line in lines:
            file_lines.append(line)

    before = True
    after = False
    test_file_lines_before = []
    test_file_lines_after = []

    indent_space_num = 0

    # Split the template file into parts before and after the target function insertion point
    for line in file_lines:
        if before:
            test_file_lines_before.append(line)
        s_line = line.strip()
        if s_line.startswith("# Write the target function here"):
            before = False
            indent_space_num = len(list(takewhile(str.isspace, line)))
        if not before and s_line.startswith("# End here"):
            after = True
        if after:
            test_file_lines_after.append(line)

    test_file_lines = []
    for line in test_file_lines_before:
        test_file_lines.append(line)

    # Replace the function name in the prediction code
    code = replace_func_name(prediction)

    # Insert the modified prediction code into the test file
    test_file_lines.append(" " * indent_space_num + code + "\n")

    for line in test_file_lines_after:
        test_file_lines.append(line)

    # Write the modified test file
    with open(test_folder + '/test.py', "w", encoding="utf-8") as f:
        for line in test_file_lines:
            f.write(line)

# Function to add unit tests to the test file
def add_tests(idx, question, function_name):

    # Format the index with leading zeros
    if idx < 10:
        idx = '00' + str(idx)
    elif idx < 100:
        idx = '0' + str(idx)
    else:
        idx = str(idx)

    # Define the test folder and template file path
    test_folder = f"unit_tests/test_files/{idx}_{function_name}"
    template_file = f'unit_tests/test_files/{idx}_{function_name}/test.py'

    file_lines = []
    with open(template_file, "r", encoding="utf-8") as f:
        lines = f.readlines()
        for line in lines:
            file_lines.append(line)

    before = True
    after = False
    test_file_lines_before = []
    test_file_lines_after = []

    indent_space_num = 0

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

    test_file_lines = []
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
def unit_tests_generator(test_values_file, predictions):

    # Load the test values from the JSON file
    with open(test_values_file, 'r') as file:
        questions = json.load(file)

    # Iterate over each question and corresponding prediction
    for i, question in enumerate(questions['questions']):
        add_function(i+1, predictions[i], question['name'])
        add_tests(i+1, question, question['name'])

    print("\nAll test files generated!\n")

    return