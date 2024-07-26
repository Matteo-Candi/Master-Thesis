import subprocess
import json
import os



def run_test_file(idx, question):

    if idx < 10:
        idx = '00' + str(idx)
    elif idx < 100:
        idx = '0' + str(idx)
    else:
        idx = str(idx)

    test_dir = "unit_tests/test_files/" + idx+ '_' + question
    test_path = test_dir + "/test.py"

    try:
        run_output = subprocess.check_output(["python", test_path], timeout=5)

    except:
        run_output = ''

    run_output = str(run_output)

    print(f"Test runned: {idx} - {question}")

    if run_output.find("All Passed!") != -1:
        return 'Pass'
    else:
        return 'Fail'



def run_all_tests(test_values_file, input_file):

    with open(test_values_file, 'r') as file:
        questions = json.load(file)

    final_results = {}
    pass_count = 0
    fail_count = 0

    for i, question in enumerate(questions['questions']):
        result = run_test_file(i+1, question['name'])

        if result == 'Pass':
            pass_count += 1
            final_results[question['name']] = 'Pass'

        else:
            fail_count += 1
            final_results[question['name']] = 'Fail'
    
    print("\nAll tests runned!\n")

    total = pass_count + fail_count
    final_results['passed'] = pass_count
    final_results['total'] = total

    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file_path = f"../results/{input_file_name}"

    os.makedirs(output_file_path, exist_ok=True)

    with open(output_file_path + "/unit_tests_results.json", 'w') as file:
        json.dump(final_results, file)

    return