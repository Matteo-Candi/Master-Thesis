import matplotlib.pyplot as plt
from collections import defaultdict
from tqdm import tqdm
import pandas as pd
import numpy as np
import json
import re

from python_evaluation import evaluate_python_code


def summary_df(input_language, step):

    df = pd.read_json(f"../{input_language}_files/translations_{step}/summary_{input_language}.json")
    df = df.T

    df[['model', 'quantization', 'col_3', 'col_4', 'version']] = df.index.to_series().str.split('_', expand=True)

    df['file'] = df['col_3'] + '_' + df['col_4']
    df.drop(['col_3', 'col_4'], axis=1, inplace=True)
    df = df.reset_index(drop=True)

    new_order = ['model', 'quantization', 'file', 'version'] + [col for col in df.columns if col not in ['model', 'quantization', 'file', 'version']]
    df = df[new_order]

    # df = df[~df['file'].str.contains('file_7')]
    df = df[~df['file'].str.contains('file_8')]
    df = df.reset_index(drop=True)

    metric_columns = ['lloc', 'primary_errors_rank', 'secondary_errors_index', 'commented_lines', 'cyclomatic_complexity_index', 'halstead_volume', 'maintainability_index', 'syntax_error']

    for metric in metric_columns:
        df[metric] = None

    df['loop'] = None
    df['partial_code'] = False


    for i in tqdm(range(len(df))):
        output, loop = file_evaluation(df.iloc[i], input_language, step)
        df.loc[i, 'loop'] = loop
        if output is not None:
            metrics = pd.Series(output['metrics'])
            df.loc[i, metrics.keys()] = metrics
            df.loc[i, 'syntax_error'] = output['syntax_error']
            df.loc[i, 'primary_error_text'] = output['primary_errors_text']
        else:
            continue

    df = df.replace('-', np.nan)

    df = add_incomplete_code(df, input_language, step)

    return df



def process_row(row, input_language, step):
    output, loop = file_evaluation(row, input_language, step)

    if output is not None:
        metrics = pd.Series(output['metrics'])
        row[metrics.index] = metrics
        row['syntax_error'] = output['syntax_error']
        row['primary_error_text'] = output['primary_errors_text']

    row['loop'] = loop

    return row



def file_evaluation(series, input_language, step):
    file_path = f"../{input_language}_files/translations_{step}/{series.model}/{series.quantization}/{series.file}_{series.version}.txt"
    if input_language == 'sas_etl':
        pass # add sql evaluation
    else:
        evaluations = evaluate_python_code(file_path)
    loop = code_in_loop(file_path)

    return evaluations, loop


def code_in_loop(file_path):

    with open(file_path, 'r') as file:
        code = file.read()

    pattern_complete = r'```python(.*?)```'
    pattern_loop = r'```python(.*?)'
    
    code_complete = re.findall(pattern_complete, code, re.DOTALL)
    code_loop = re.findall(pattern_loop, code, re.DOTALL)

    if len(code_loop) > len(code_complete):
        return True
 
    return False


def syntax_error_or_missing_count(df, with_version=True):

    list_group = ['model', 'version'] if with_version else ['model']

    all_models = pd.DataFrame(df[list_group].drop_duplicates())

    count_condition_1 = df[(df['maintainability_index'].isna()) & (df['syntax_error'].notna())].groupby(list_group).size().reset_index(name='code_w_syntax_errors')
    count_condition_2 = df[(df['maintainability_index'].isna()) & (df['syntax_error'].isna())].groupby(list_group).size().reset_index(name='code_not_available')
    count_condition_3 = df[df['loop'] == True].groupby(list_group).size().reset_index(name='code_in_loop')
    count_condition_4 = df[df['partial_code'] == True].groupby(list_group).size().reset_index(name='partial_code')

    result_1 = all_models.merge(count_condition_1, on=list_group, how='left').fillna(0)
    result_2 = all_models.merge(count_condition_2, on=list_group, how='left').fillna(0)
    result_3 = all_models.merge(count_condition_3, on=list_group, how='left').fillna(0)
    result_4 = all_models.merge(count_condition_4, on=list_group, how='left').fillna(0)

    result_1['code_w_syntax_errors'] = result_1['code_w_syntax_errors'].astype(int)
    result_2['code_not_available'] = result_2['code_not_available'].astype(int)
    result_3['code_in_loop'] = result_3['code_in_loop'].astype(int)
    result_4['partial_code'] = result_4['partial_code'].astype(int)

    # Merging both results
    final_result = result_1.merge(result_2, on=list_group)
    final_result = final_result.merge(result_3, on=list_group)
    final_result = final_result.merge(result_4, on=list_group)

    return final_result


def add_incomplete_code(df, input_language, step):

    incomplete_tranlsations_list = []

    if step == 2 and input_language == 'sas':
        step_2 = [
            'Artigenz-Coder-DS-6.7B_file_5_v1',
            'Magicoder-S-DS-6.7B_file_4_v1',
            'Magicoder-S-DS-6.7B_file_4_v2',
            'Magicoder-S-DS-6.7B_file_5_v1',
            'Magicoder-S-DS-6.7B_file_6_v1',
            'OpenCodeInterpreter-DS-33B_file_5_v1',
            'OpenCodeInterpreter-DS-33B_file_5_v2',
            'OpenCodeInterpreter-DS-33B_file_6_v2',
            'deepseek-coder-33b-instruct_file_4_v1',
            'deepseek-coder-33b-instruct_file_4_v2',
            'deepseek-coder-33b-instruct_file_5_v1',
            'deepseek-coder-33b-instruct_file_5_v2',
            'deepseek-coder-33b-instruct_file_6_v1',
            'deepseek-coder-33b-instruct_file_7_v1',
            'deepseek-coder-33b-instruct_file_7_v2',
            'deepseek-coder-33b-instruct_file_8_v1',
            'deepseek-coder-33b-instruct_file_8_v2',
        ]
        incomplete_tranlsations_list += step_2

    if step == 3 and input_language == 'sas':
        step_3 = [
            'Artigenz-Coder-DS-6.7B_file_5_v2',
            'Artigenz-Coder-DS-6.7B_file_6_v1',
            'Artigenz-Coder-DS-6.7B_file_6_v2',
            'Artigenz-Coder-DS-6.7B_file_7_v1',
            'CodeQwen1.5-7B-Chat_file_5_v1',
            'Magicoder-S-DS-6.7B_file_4_v2',
            'Magicoder-S-DS-6.7B_file_6_v1',
            'Magicoder-S-DS-6.7B_file_6_v2',
            'Magicoder-S-DS-6.7B_file_7_v1',
            'Magicoder-S-DS-6.7B_file_7_v2',
            'OpenCodeInterpreter-DS-33B_file_5_v2',
            'OpenCodeInterpreter-DS-33B_file_7_v2',
            'deepseek-coder-33b-instruct_file_4_v2',
            'deepseek-coder-33b-instruct_file_5_v2',
            'deepseek-coder-33b-instruct_file_6_v2',
            'deepseek-coder-33b-instruct_file_7_v1',
            'deepseek-coder-33b-instruct_file_7_v2',
        ]
        incomplete_tranlsations_list += step_3



    for file in incomplete_tranlsations_list:
        splitted_file = file.split('_')
        file_dict = {'model': splitted_file[0],
                    'file': '_'.join(splitted_file[1:3]),
                    'version': splitted_file[3]}
        
        df.loc[(df['model'] == file_dict['model']) & 
            (df['file'] == file_dict['file']) & 
            (df['version'] == file_dict['version']), 'partial_code'] = True
        
    return df


def print_times(path):

    with open(path, 'r') as file:
        data = json.load(file)


    v1_dict = {}
    v2_dict = {}

    for key, value in data.items():
        split_key = key.split('_')
        model = split_key[0]
        version = split_key[-1]
        file = '_'.join(split_key[2:4])

        if version == 'v1' and file != 'file_8':
            if model in v1_dict.keys():
                v1_dict[model].update({file: value['time']})
            else:
                v1_dict[model] = {file: value['time']}

        elif version == 'v2' and file != 'file_8':
            if model in v2_dict.keys():
                v2_dict[model].update({file: value['time']})
            else:
                v2_dict[model] = {file: value['time']}

    df_v1 = pd.DataFrame(v1_dict).T
    df_v2 = pd.DataFrame(v2_dict).T

    return df_v1, df_v2


def get_avg_input_tokens(path, language):
    with open(path, 'r') as file:
        data = json.load(file)


    v1_dict = {}
    v2_dict = {}

    for key, value in data.items():
        split_key = key.split('_')
        model = split_key[0]
        version = split_key[-1]
        file = '_'.join(split_key[2:4])

        if version == 'v1' and file != 'file_8':
            if model in v1_dict.keys():
                v1_dict[model].update({file: value['input_tokens']})
            else:
                v1_dict[model] = {file: value['input_tokens']}

        elif version == 'v2' and file != 'file_8':
            if model in v2_dict.keys():
                v2_dict[model].update({file: value['input_tokens']})
            else:
                v2_dict[model] = {file: value['input_tokens']}

    if language == 'sas': 
        file_len = 7
    elif language == 'sql':
        file_len = 6

    avg_times_1 = [0] * file_len
    for key, value in v1_dict.items():
        for i in range(1, file_len+1):
            avg_times_1[i-1] += value[f'file_{i}'] / 6

    avg_times_2 = [0] * file_len
    for key, value in v2_dict.items():
        for i in range(1, file_len+1):
            avg_times_2[i-1] += value[f'file_{i}'] / 6

    return avg_times_1, avg_times_2


def plot_syntax_error_or_missing_count(df):

    final_result = syntax_error_or_missing_count(df)

    models = final_result['model'].unique()
    versions = final_result['version'].unique()

    # Set the width of each bar
    bar_width = 0.2
    num_models = len(models)
    index = np.arange(num_models)

    # Plotting
    plt.figure(figsize=(15, 5))

    # Iterate over each version
    for i, version in enumerate(versions):
        # Get counts for code with syntax errors and code not available for each model
        code_w_syntax_errors = final_result[final_result['version'] == version]['code_w_syntax_errors']
        code_not_available = final_result[final_result['version'] == version]['code_not_available']

        # Plot bars for code with syntax errors
        if version =='v1': 
            col_1 = -1.5
            col_2 = -0.5 
        else: 
            col_1 = -0.5
            col_2 = 0.5
        
        plt.bar(index + (i + col_1) * bar_width, code_w_syntax_errors, bar_width, label=f'{version} - Code with Syntax Errors')

        # Plot bars for code not available
        plt.bar(index + (i + col_2) * bar_width, code_not_available, bar_width, label=f'{version} - Code Not Available')

    # Add labels and legend
    plt.xlabel('Models')
    plt.ylabel('Counts')
    plt.title('Counts for Models')
    plt.xticks(index, models)
    plt.legend()
    plt.tight_layout()
    plt.show()
    

def primary_error_count(df):
    result = df.groupby(['model', 'version'])['primary_errors_rank'].value_counts(dropna=False).unstack(fill_value=0)

    column_order = ['Good', 'Mediocre', 'Poor', 'Very poor', 'Extremely poor', np.nan]
    result = result.reindex(columns=column_order, fill_value=0) 

    result['Total'] = result.sum(axis=1)

    return result


def avgs_results(df):

    return df.groupby(['model', 'version'])[['time', 'commented_lines', 'halstead_volume', 'secondary_errors_index', 'cyclomatic_complexity_index']].mean()


def extract_avg_values(code_type='sas', metric='input_tokens', step=1):
        
    with open(f"../{code_type}_files/translations_{step}/summary_{code_type}.json", 'r') as file:
        summary = json.load(file)

    if code_type == 'sas':
        i = 8
    elif code_type == 'sql':
        i = 6

    input_tokens = {'v1': [0]*i, 'v2': [0]*i}

    for key, value in summary.items():
        parts = key.split('_')
        file_number = parts[-2]
        version = parts[-1]
        if version in ['v1', 'v2']:
            input_tokens[version][int(file_number)-1] += value[metric]

    for key in input_tokens:
        input_tokens[key] = [round(x / 4) for x in input_tokens[key]]

    return input_tokens


def plot_summary(code_type='sas', model_name='CodeQwen1.5-7B-Chat', step=1):

    with open(f"../{code_type}_files/translations_{step}/summary_{code_type}.json", 'r') as file:
        summary = json.load(file)

    if code_type == 'sas':
        i = 8
    elif code_type == 'sql':
        i = 6

    data = {'v1': {'input_tokens': [0]*i, 'output_tokens': [0]*i, 'time': [0]*i, 'max_length': [0]*i}, 'v2': {'input_tokens': [0]*i, 'output_tokens': [0]*i, 'time': [0]*i, 'max_length': [0]*i}}

    for key, value in summary.items():
        if model_name not in key:
            continue
        parts = key.split('_')
        version = parts[-1]
        file_number = parts[-2]
        if version in ['v1', 'v2']:
            for metric, metric_value in value.items():
                data[version][metric][int(file_number)-1] = metric_value

    # Create subplots
    fig, axs = plt.subplots(2, 2, figsize=(12, 7))

    fig.suptitle(model_name, fontsize=16)    

    # Plot v1 input_tokens vs. time
    axs[0, 0].plot(data['v1']['input_tokens'], data['v1']['time'], marker='o', label='v1')
    axs[0, 0].set_title('v1: input_tokens vs. time')
    axs[0, 0].set_xlabel('input_tokens')
    axs[0, 0].set_ylabel('time (s)')

    # Plot v1 output_tokens vs. time
    axs[0, 1].plot(data['v1']['output_tokens'], data['v1']['time'], marker='o', label='v1')
    axs[0, 1].set_title('v1: output_tokens vs. time')
    axs[0, 1].set_xlabel('output_tokens')
    axs[0, 1].set_ylabel('time (s)')

    # Plot v2 input_tokens vs. time
    axs[1, 0].plot(data['v2']['input_tokens'], data['v2']['time'], marker='o', label='v2')
    axs[1, 0].set_title('v2: input_tokens vs. time')
    axs[1, 0].set_xlabel('input_tokens')
    axs[1, 0].set_ylabel('time (s)')

    # Plot v2 output_tokens vs. time
    axs[1, 1].plot(data['v2']['output_tokens'], data['v2']['time'], marker='o', label='v2')
    axs[1, 1].set_title('v2: output_tokens vs. time')
    axs[1, 1].set_xlabel('output_tokens')
    axs[1, 1].set_ylabel('time (s)')

    # Add legend
    for ax in axs.flat:
        ax.legend()

    # Adjust layout
    plt.tight_layout()

    # Show the plot
    plt.show()