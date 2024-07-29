import argparse

from formatter import extract_references, extract_predictions
from metrics import metrics_values
from unit_tests.generator import unit_tests_generator
from unit_tests.runner import run_all_tests
from translation import generate_translations




if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--filename", required=False)
    args = parser.parse_args()

    if args.filename is None:
        print("Please provide a file name")
        exit()

    java_data_path = '../benchmark/Java.test'

    generate_translations(java_data_path, args.filename)

    predictions = extract_predictions(args.filename)
    references = extract_references("../benchmark/Python.test")

    test_values_file = 'unit_tests/test_values.json'

    unit_tests_generator(test_values_file, predictions)

    run_all_tests(test_values_file, args.filename)

    metrics_values(references, predictions, args.filename)

