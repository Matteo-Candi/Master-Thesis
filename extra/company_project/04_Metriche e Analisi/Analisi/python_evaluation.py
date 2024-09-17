import ast
import traceback
import black
from io import StringIO
from contextlib import redirect_stdout
from pylint.lint import Run
from radon.raw import analyze
from radon.metrics import mi_visit, mi_rank, mi_parameters

import re
from collections import Counter



def create_temporary_file(new_file, temporary_file):

    with open(new_file, 'r') as file:
        translation = file.read()

    pattern = r'```python(.*?)```'
    
    code_blocks = re.findall(pattern, translation, re.DOTALL|re.IGNORECASE)

    code = "\n".join(code_blocks).strip()

    with open(temporary_file, 'w') as file:
        file.write(code)

    if code == '':
        return False
    else:
        return True


def compilation_errors_check(file):
    """
    Checks for compilation errors in the Python source file.

    Parameters:
    - file (str): The path to the Python source file to be checked.

    Returns:
    - valid (bool): True if the source file is syntactically valid, False otherwise.
    - error_message (str or None): A string containing the traceback information
      if a SyntaxError occurs during parsing, otherwise None.
    """
    with open(file) as f:
        source = f.read()

    valid = True
    error_text = None

    try:
        ast.parse(source)
    except SyntaxError:
        valid = False
        # Capture the traceback information as a string
        error_text = traceback.format_exc(limit=0)

    return valid, error_text


def format_file(file):
    """
    Formats the Python source code in the specified file using Black.

    Parameters:
    - file (str): The path to the Python source file to be formatted.

    Returns:
    - bool: True if the code is successfully formatted, False if no changes are needed (already formatted).
    """
    black_mode = black.FileMode()

    # Read the input file
    with open(file, "r") as f:
        input_code = f.read()

    # Format the code using Black
    try:
        formatted_code = black.format_file_contents(
            input_code, fast=True, mode=black_mode
        )

        # Write the formatted code back to the input file
        with open(file, "w") as f:
            f.write(formatted_code)

        return True  # Code was successfully formatted
    except black.NothingChanged:
        return False  # Code was already properly formatted


def clean_code_criteria(file, warnings):
    """
    Runs Pylint on the specified Python source file to assess code quality based on predefined criteria.

    Parameters:
    - file (str): The path to the Python source file to be assessed.

    Returns:
    - str: The output of Pylint analysis containing information about code quality.
    """
    with open(file, "r") as f:
        content = f.read()

    spark_functions_import = False
    if 'pyspark.sql.functions' in content:
        spark_functions_import = True
    

    output = StringIO()  # Create a StringIO object to capture the output
    try:
        with redirect_stdout(output):  # Redirect standard output to the StringIO object
            _ = Run([file, "--disable=all", f"--enable={warnings}"])
    except SystemExit:
        pass  # Suppress SystemExit exception

    # After running Pylint, return the captured output as a string
    return output.getvalue(), spark_functions_import


def clean_code_criteria_summary(file, warnings):
    """
    Summarizes the output of Pylint by extracting error codes and their corresponding descriptions.

    Parameters:
    - output (str): The output text of Pylint.

    Returns:
    - error_dict (Counter): A Counter object containing the counts of each error code.
    - errors_text (str): A string containing the descriptions of the errors.
    """

    output, spark_functions_import = clean_code_criteria(file, warnings)

    errors_list, errors_text = [], ""

    # Iterate through each line of the output, excluding the first and last 4 lines
    for line in output.splitlines()[1:-4]:

        # Find the match in the input line to remove the path
        pattern = r"\b[A-Z]\d{4}\b"
        match = re.search(pattern, line)
        line = line[match.start() :]

        # Split the line and extract the error code
        cutted_line = line.split()[1:]
        errors_list.append(cutted_line[-1])

        # Extract the error description and append it to the errors_text
        cutted_line = line.split()[1:-1]
        errors_text += " ".join(cutted_line) + "\n"

    # Count the occurrences of each error code
    error_dict = Counter(errors_list)

    # remove sparkl built in errors
    if spark_functions_import and 'W0622' in warnings:
        built_in_words = ['abs', 'max', 'min', 'sum', 'pow', 'round', 'hash', 'ascii', 'bin', 'hex', 'slice', 'filter']
        for word in built_in_words:
            error = f"Redefining built-in '{word}'\n"
            if error in errors_text:
                errors_text = errors_text.replace(error, '')
                error_dict['(redefined-builtin)'] -= 1

    if error_dict['(redefined-builtin)'] == 0:
        del error_dict['(redefined-builtin)']


    # Remove same undefined variable multiple times
    errors_text = errors_text.split('\n')
    undefined_list = []
    for error in errors_text:
        if 'Undefined variable' in error:
            undefined_list.append(error)
    undefined_list = list(set(undefined_list))

    errors_text = '\n'.join(errors_text)
    for error in undefined_list:
        old_len, new_len = 1, 0
        while old_len > new_len:
            old_len = len(errors_text)
            errors_text = errors_text.replace(error + '\n', '')
            new_len = len(errors_text)
            error_dict['(undefined-variable)'] -= 1

    for error in undefined_list:
        errors_text += error + '\n'

    return error_dict, errors_text



def metrics(file):
    """
    Calculates various code metrics for the specified Python source file.

    Parameters:
    - file (str): The path to the Python source file for which metrics are to be calculated.

    Returns:
    - tuple: A tuple containing the calculated metrics:
        - visit (int): Cyclomatic complexity (also known as visit count).
        - rank (str): Maintainability index rank.
        - params (dict): Various code metrics parameters.
    """

    # metrics documentation: https://radon.readthedocs.io/en/latest/intro.html

    with open(file, "r") as f:
        content = f.read()
        visit = mi_visit(content, multi=False)
        rank = mi_rank(visit)
        params = mi_parameters(content, count_multi=False)

    return visit, rank, params


def lines_summary(file_path):
    """
    Analyze a source code file and return a summary of line metrics.

    Args:
        file_path (str): The path to the source code file to be analyzed.

    Returns:
        tuple: A tuple containing the following line metrics:
            - lloc (int): Logical Lines of Code.
            - sloc (int): Source Lines of Code.
            - commented_lines_percentage (float): Percentage of commented lines.
    """

    with open(file_path, "r") as file:
        source = file.read() 
        loc, lloc, sloc, comments, _, blank, _ = analyze(source)
        commented_lines_percentage = round(comments / (loc - blank) * 100 , 1)

    return lloc, sloc, commented_lines_percentage



def primary_errors_rank_discretizer(primary_errors_dict):
    """
    Ranks primary errors based on the total count.

    This function calculates the rank of primary errors based on the total count of primary errors
    provided in the input dictionary. It assigns a rank label ('A', 'B', 'C', 'D', 'E') based on
    predefined thresholds.

    Args:
    - primary_errors_dict (dict): A dictionary containing counts of primary errors.

    Returns:
    - str: The rank label assigned to the total count of primary errors.
    """
    value = primary_errors_dict.total()

    thresholds = [0, 3, 6, 10]
    labels = ['Good', 'Mediocre', 'Poor', 'Very poor', 'Extremely poor']

    for i, threshold in enumerate(thresholds):
        if value <= threshold:
            return labels[i]
    # If the value exceeds all thresholds, return the last label
    return labels[-1]




def evaluate_python_code(file: str) -> dict:
    """
    Evaluate Python code quality and compute metrics.

    Args:
        file (str): The path to the Python file to evaluate.

    Returns:
        dict: A dictionary containing evaluation results and computed metrics.
    """

    # metrics documentation: https://radon.readthedocs.io/en/latest/intro.html

    evaluation_keys = ['primary_errors', 'secondary_errors', 'primary_errors_text', 'secondary_errors_text', 'metrics']
    metrics_keys = ['lloc', 'primary_errors_rank', 'secondary_errors_index', 'commented_lines', 'cyclomatic_complexity_index', 'halstead_volume', 'maintainability_index']


    temp_file_path = "temp_file.txt"
    calculate_metrics = create_temporary_file(file, temp_file_path)

    # If the translation is missing or never ended.
    if not calculate_metrics:
        # print(f'No code found in the file: {file}')
        return None

    file = temp_file_path

    # Check for compilation errors
    valid_code, syntax_error_text = compilation_errors_check(file)

    if valid_code:

        # Format the code
        _ = format_file(file)

        # Define error codes
        primary_warning = "C0102, E0100, E0101, E0103, E0104, E0105, E0106, E0107, E0108, E0110, E0112, E0113, E0114, E0115, E0116, E0117, E0118, E0119, R0123, W0101, W0109, W0111, W0120, W0122, W0124, W0126, W0143, W0150, W0199, E0202, E0203, E0213, E0236, E0237, E0238, E0239, E0240, E0241, E0301, E0302, E0303, R0202, R0203, W0201, W0211, W0212, W0221, W0223, W0231, W0233, W0236, E0701, W0715, W0716, E1201, W1201, E1200, W0714, R0401, W0402, W0406, E0402, E1507, W1501, W1502, W1505, W1506, W1507, W1508, W1509, W1510, R1707, E1300, E1301, E1302, E1303, E1304, E1305, E1306, E1307, E1310, W1300, W1302, W1303, W1305, W1306, W1307, W1402, W1401, W1403, E0601, E0602, E0603, E0604, E0611, E0633, W0601, W0602, W0604, W0622, W0632, W0640, W0642, E1101, E1102, E1111, E1120, E1123, E1124, E1125, E1126, E1127, E1129, E1130, E1131, E1132, E1133, E1134, E1135, E1136, E1137, E1138, E1139, E1140, E1141, I1101, E0242, F0202, W0222"
        secondary_warnings = "C0116, C0115, C0121, C0122, C0123, E0102, E0111, R0124, W0102, W0104, W0105, W0106, W0107, W0108, W0123, W0127, W0128, W0717, W0125, C0202, C0203, C0204, C0205, E0211, R0201, R0206, W0141, R0901, R0902, R0903, R0904, R0911, R0912, R0913, R0914, R0915, R0916, R1260, R5501, E0702, E0703, E0704, E0710, E0712, W0702, W0703, W0705, W0706, W0707, W0711, W0311, W0312, C0302, E1003, C0411, C0412, C0413, C0414, C0415, W0401, W0404, W0410, W9017, W9018, C0401, C0402, C0403, W1503, C0113, C0200, C0201, C1801, R1701, R1702, R1703, R1704, R1705, R1706, R1708, R1709, R1710, R1711, R1712, R1713, R1714, R1715, R1716, R1717, R1718, R1719, R1720, R1721, R1722, R1723, R1724, W1301, W1304, W1308, W0603, W0614, W0621, W0623, W0631, W0641, E1121, E1128, W1113, W1114, C0112, C0114, W0611, W0612, W0613"
        discarded_warnings = "E0401, E1700, E1701, R0205, W0232, W0235, C0103, C1901, C2001, C0198, C0199, E0711, C0301, C0303, C0304, C0305, C0321, C0325, C0326, C0327, C0328, W0301, C0330, E1205, E1206, W1202, I0023, W0511, R0204, C0410, W0407, W9016, W9012, W9013, W9014, W9005, W9006, W9008, W9010, W9011, W9015, R0801"

        # Check for primary errors
        primary_errors_dict, primary_errors_text = clean_code_criteria_summary(file, primary_warning)

        # Check for secondary errors
        secondary_errors_dict, secondary_errors_text = clean_code_criteria_summary(file, secondary_warnings)

        # Compute metrics
        maintainability, _, params = metrics(file)

        lloc, sloc, comment_lines = lines_summary(file)
        if lloc == 0:
            return None
        
        maintainability = round(maintainability, 1)
        halstead_volume = round(params[0], 1)
        cyclomatic_complexity = round(params[1] / lloc * 100, 1)
        primary_errors_rank = primary_errors_rank_discretizer(primary_errors_dict)
        secondary_errors_index = round(secondary_errors_dict.total() / sloc, 2)

        metrics_values = [lloc, primary_errors_rank, secondary_errors_index, comment_lines, cyclomatic_complexity, halstead_volume, maintainability]
        metrics_dict = dict(zip(metrics_keys, metrics_values))
        
        evaluation_values = [primary_errors_dict, secondary_errors_dict, primary_errors_text, secondary_errors_text, metrics_dict]
        evaluation_results = dict(zip(evaluation_keys, evaluation_values))

        evaluation_results['syntax_error'] = None
        
    else:
        # Empty values for the other metrics.
        evaluation_results = {key: '-' for key in evaluation_keys}
        metrics_dict = {key: '-' for key in metrics_keys}
        evaluation_results['metrics'] = metrics_dict

        # Syntax error detected
        evaluation_results["syntax_error"] = syntax_error_text

    return evaluation_results
