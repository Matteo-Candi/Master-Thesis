import argparse

from formatter import extract_references, extract_predictions
from metrics import metrics_values
from unit_tests.generator import unit_tests_generator
from unit_tests.runner import run_all_tests




if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--input_file", required=False)
    args = parser.parse_args()

    predictions = extract_predictions(args.input_file)
    references = extract_references("../benchmark/Python.test")

    test_values_file = 'unit_tests/test_values.json'

    unit_tests_generator(test_values_file, predictions)

    run_all_tests(test_values_file, args.input_file)

    metrics_values(references, predictions, args.input_file)

