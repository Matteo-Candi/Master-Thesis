import json
import os
import re

from codebleu import calc_codebleu

# Function to calculate the BLUE score
def BLUE_score(reference, prediction):
    result = calc_codebleu([reference], [prediction], lang="python", weights=(1, 0, 0, 0), tokenizer=None)
    return result['codebleu']

# Function to calculate the CodeBLEU score
def CodeBLEU_score(reference, prediction):
    result = calc_codebleu([reference], [prediction], lang="python", weights=(0.25, 0.25, 0.25, 0.25), tokenizer=None)
    return result['codebleu']

# Function to calculate single BLEU scores for a reference and prediction
def single_bleu_scores(reference, prediction):
    
    # Exclude import statements from the comparison
    prediction = prediction.split('\n')
    prediction = [line for line in prediction if 'import' not in line]
    prediction = '\n'.join(prediction)

    # Exclude function name from the comparison
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

# Function to calculate average BLEU scores for a list of references and predictions
def average_bleu_scores(references, predictions):
    results = []

    for i, (reference, prediction) in enumerate(zip(references, predictions), 1):
        metrics = single_bleu_scores(reference, prediction)
        results.append(metrics)

    total_blue = 0
    total_codebleu = 0
    count = len(results)

    for entry in results:
        total_blue += entry['BLUE']
        total_codebleu += entry['CodeBLEU']

    mean_blue = total_blue / count
    mean_codebleu = total_codebleu / count

    return {'BLUE': mean_blue, 'CB': mean_codebleu}

# Function to calculate computational accuracy based on unit test results
def computational_accuracy(input_file):
    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file_path = f"../results/{input_file_name}/unit_tests_results.json"

    with open(output_file_path, 'r') as file:
        unit_tests_results = json.load(file)

    computational_accuracy = unit_tests_results['passed'] / unit_tests_results['total']

    return computational_accuracy

# Function to calculate and save final metrics
def metrics_values(references, predictions, input_file):
    final_metrics = average_bleu_scores(references, predictions)
    computation_accuracy = computational_accuracy(input_file)
    final_metrics.update({'CA': computation_accuracy})

    input_file_name = os.path.basename(input_file).split('.')[0]
    output_file = f"../results/{input_file_name}/metrics.json"

    if os.path.exists(output_file):
        with open(output_file, 'r') as file:
            existing_data = json.load(file)
        existing_data.update(final_metrics)
        with open(output_file, 'w') as file:
            json.dump(existing_data, file)
    else:
        with open(output_file, 'w') as file:
            json.dump(final_metrics, file)

    print(f"\nFinal metrics for {input_file_name}: {final_metrics}\n")

    return