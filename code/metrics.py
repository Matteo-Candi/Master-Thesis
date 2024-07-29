import json
import os
import re

from codebleu import calc_codebleu



def BLUE_score(reference, prediction):
    result = calc_codebleu([reference], [prediction], lang="python", weights=(1, 0, 0, 0), tokenizer=None)

    return result['codebleu']


def CodeBLEU_score(reference, prediction):
    result = calc_codebleu([reference], [prediction], lang="python", weights=(0.25, 0.25, 0.25, 0.25), tokenizer=None)

    return result['codebleu']


def single_bleu_scores(reference, prediction):

    # Excluding import statements from the comparison
    prediction = prediction.split('\n')
    prediction = [line for line in prediction if 'import' not in line]
    prediction = '\n'.join(prediction)

    # Excluding function name from the comparison
    pattern = r'def\s+(\w+)\s*\('
    prediction = re.sub(pattern, 'def function_name(', prediction)
    reference = re.sub(pattern, 'def function_name(', reference)

    blue = BLUE_score(reference, prediction)
    code_blue = CodeBLEU_score(reference, prediction)

    result_metrics = {
        'BLUE': blue,
        'CodeBLEU': code_blue
    }

    return result_metrics


def average_bleu_scores(references, predictions):
    results = []

    i = 1
    for reference, prediction in zip(references, predictions):
        metrics = single_bleu_scores(reference, prediction)
        results.append(metrics)
        # print(f"Metrics for example {i}: {metrics}")
        i += 1

    total_blue = 0
    total_codebleu = 0
    count = len(results)

    for entry in results:
        total_blue += entry['BLUE']
        total_codebleu += entry['CodeBLEU']

    mean_blue = total_blue / count
    mean_codebleu = total_codebleu / count

    return {'BLUE': mean_blue, 'CB': mean_codebleu}


def computational_accuracy(input_file):

    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file_path = f"../results/{input_file_name}/unit_tests_results.json"

    with open(output_file_path, 'r') as file:
        unit_tests_results = json.load(file)

    comnputational_accuracy = unit_tests_results['passed'] / unit_tests_results['total']

    return comnputational_accuracy


def metrics_values(references, predictions, input_file):
    final_metrics = average_bleu_scores(references, predictions)
    computation_accuracy = computational_accuracy(input_file)
    final_metrics.update({'CA': computation_accuracy})

    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file= f"../results/{input_file_name}/metrics.json"

    if os.path.exists(output_file):
        # Load existing data
        with open(output_file, 'r') as file:
            existing_data = json.load(file)
        
        # Append new metrics to existing data
        existing_data.update(final_metrics)
        
        # Write the updated data back to the file
        with open(output_file, 'w') as file:
            json.dump(existing_data, file)
    else:
        # Write new metrics to the file
        with open(output_file, 'w') as file:
            json.dump(final_metrics, file)

    print(f"\nFinal metrics for {input_file_name}: {final_metrics}\n")

    return 