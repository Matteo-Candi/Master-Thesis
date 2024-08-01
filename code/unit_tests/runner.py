import subprocess
import json
import os

# Function to run a single test file
def run_test_file(idx, question):

    # Format the index with leading zeros
    if idx < 10:
        idx = '00' + str(idx)
    elif idx < 100:
        idx = '0' + str(idx)
    else:
        idx = str(idx)

    # Define the directory and path for the test file
    test_dir = "unit_tests/test_files/" + idx + '_' + question
    test_path = test_dir + "/test.py"

    try:
        # Run the test file using subprocess and set a timeout
        run_output = subprocess.check_output(["python", test_path], timeout=5)
    except:
        # Handle any exceptions by setting run_output to an empty string
        run_output = ''

    # Convert the output to a string
    run_output = str(run_output)

    # Print the test run status
    print(f"Test runned: {idx} - {question}")

    # Check if the test passed or failed
    if run_output.find("All Passed!") != -1:
        return 'Pass'
    else:
        return 'Fail'

# Function to run all test files
def run_all_tests(test_values_file, input_file):
    
    # Load the test values from the JSON file
    with open(test_values_file, 'r') as file:
        questions = json.load(file)

    # Initialize the final results dictionary and counters
    final_results = {}
    pass_count = 0
    fail_count = 0

    # Iterate over each question and run the corresponding test file
    for i, question in enumerate(questions['questions']):
        result = run_test_file(i+1, question['name'])

        # Update the counters and final results based on the test result
        if result == 'Pass':
            pass_count += 1
            final_results[question['name']] = 'Pass'
        else:
            fail_count += 1
            final_results[question['name']] = 'Fail'
    
    # Print the completion message
    print("\nAll tests runned!\n")

    # Calculate the total number of tests
    total = pass_count + fail_count
    final_results['passed'] = pass_count
    final_results['total'] = total

    # Define the output file path
    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file_path = f"../results/{input_file_name}"

    # Create the output directory if it doesn't exist
    os.makedirs(output_file_path, exist_ok=True)

    # Write the final results to a JSON file
    with open(output_file_path + "/unit_tests_results.json", 'w') as file:
        json.dump(final_results, file)

    return