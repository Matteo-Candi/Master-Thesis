import argparse

# Import necessary functions from different modules
from formatter import extract_references, extract_predictions
from metrics import metrics_values
from unit_tests.generator import unit_tests_generator
from unit_tests.runner import run_all_tests
from translation import generate_translations

if __name__ == "__main__":
    
    # Set up argument parsing
    parser = argparse.ArgumentParser()
    parser.add_argument("--filename", required=False)
    args = parser.parse_args()

    # Check if a filename is provided
    if args.filename is None:
        print("Please provide a file name")
        exit()

    # Define the path to the Java test data
    java_data_path: str = '../benchmark/Java.test'

    # Generate translations from Java to Python
    generate_translations(java_data_path, args.filename)

    # Extract predictions from the generated translations
    predictions: list[str] = extract_predictions(args.filename)

    # Extract references from the Python test data
    references: list[str] = extract_references("../benchmark/Python.test")

    # Define the path to the test values JSON file
    test_values_file: str = 'unit_tests/test_values.json'

    # Generate unit tests based on the predictions
    unit_tests_generator(test_values_file, predictions)

    # Run all generated unit tests
    run_all_tests(test_values_file, args.filename)

    # Calculate and save metrics based on references and predictions
    metrics_values(references, predictions, args.filename)