from transformers import AutoTokenizer, AutoModelForCausalLM
import torch.nn as nn
import torch
import json
import os

# Custom Identity Self-Attention Layer
class IdentitySelfAttention(nn.Module):
    def __init__(self, config):
        super().__init__()
        self.config = config

    # def forward(self, hidden_states, attention_mask=None, head_mask=None, output_attentions=False, position_ids=None, past_key_value=None, use_cache=False, query_length=None, cache_position=None):
    def forward(self, hidden_states, **kwargs):

        hidden_states = 2 * hidden_states

        return hidden_states, None, None

# Function to reduce the model by setting specified layers' attention to identity
def model_reduction(model, S):
    if len(S) != 0:
        layers = model.model.layers
        for idx in S:
            layers[idx].self_attn = IdentitySelfAttention(layers[idx].self_attn.config)

    return model

# Function to get logits from the model
def get_logits(input_ids, model, tokenizer, base=False, max_length=300):
    temperature = 0.1
    eos_token_id = tokenizer.eos_token_id
    all_logits = []

    for _ in range(max_length):
        with torch.no_grad():
            outputs = model(input_ids)
            logits = outputs.logits[:, -1, :] / temperature
            all_logits.append(logits)
        
        probabilities = torch.nn.functional.softmax(logits, dim=-1)
        next_token_id = torch.multinomial(probabilities, num_samples=1)
        input_ids = torch.cat((input_ids, next_token_id), dim=-1)
        
        if next_token_id.item() == eos_token_id:
            break

    if base:
        max_length = len(all_logits)
        return all_logits, max_length
    
    return all_logits

# Function to calculate entropy from logits
def get_entropy(logits):
    logits = torch.cat(logits, dim=0)
    entropy = torch.log2(torch.std(logits.float(), 0)).sum()
    return entropy.item()

# Single step of the NOSE algorithm
def single_step_NOSE(input_ids_list, pretrained_model, tokenizer, S, filename):
    model = model_reduction(pretrained_model, S)
    n_samples = len(input_ids_list)
    print('\n      Running baseline...')

    # Calculate avarege base entropy
    avg_base_entropy = 0
    max_length_list = []
    for j, input_ids in enumerate(input_ids_list):
        print(f'            Running sample {j+1}/{n_samples}...')
        base_logits, max_length = get_logits(input_ids, model, tokenizer, base=True)
        base_entropy = get_entropy(base_logits)
        avg_base_entropy += base_entropy / n_samples
        max_length_list.append(max_length)

    entropy_dict = {}
    num_attention_layers = pretrained_model.config.num_attention_heads

    for i in range(num_attention_layers):
        print(f'\n      Running layer {i+1}/32...')
        if i not in S:
            model = model_reduction(model, [i])

            # Caclulate average entropy for the current layer
            avg_entropy = 0
            for j, input_ids in enumerate(input_ids_list):
                print(f'            Running sample {j+1}/{n_samples}...')
                logits = get_logits(input_ids, model, tokenizer, max_length=max_length_list[j])
                entropy = get_entropy(logits)
                avg_entropy += entropy / n_samples

            entropy_dict[i] = avg_entropy

    transfer_entropy_dict = {layer: avg_base_entropy - entropy for layer, entropy in entropy_dict.items()}
    step_layer = int(min(transfer_entropy_dict, key=transfer_entropy_dict.get))

    step_dict = {
        'S': S + [step_layer],
        'base_entropy': avg_base_entropy,
        'entropy': entropy_dict,
        'transfer_entropy': transfer_entropy_dict,
    }

    step = len(S)
    mose_dict_file = json.load(open(filename, 'r'))
    mose_dict_file[f'step_{step}'] = step_dict
    json.dump(mose_dict_file, open(filename, 'w'))

    print(f'\n     Layer to remove: {step_layer} with transfer entropy: {transfer_entropy_dict[step_layer]}')

    return step_layer

# NOSE algorithm to iteratively reduce the model
def NOSE(input_ids_list, pretrained_model, tokenizer, max_steps=32):
    filename = 'NOSE_results.json'
    if not os.path.exists(filename):
        json.dump({}, open(filename, 'w'))

    S = [0, 2, 1, 7, 9, 5, 17, 30]
    for _ in range(max_steps):
        print(f'\n\nRunning step {len(S)}...')
        step_layer = single_step_NOSE(input_ids_list, pretrained_model, tokenizer, S, filename)
        S.append(step_layer)

    return



def main():

    # Load pre-trained model and tokenizer
    tokenizer = AutoTokenizer.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B")
    pretrained_model = AutoModelForCausalLM.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B").to('cuda')

    number_input_sample = 10

    # Get the 10 shortest samples
    with open('../benchmark/Java.test', 'r') as file:
        all_samples = [line.strip() for line in file]

    samples = sorted(all_samples, key=len)[:number_input_sample]

    input_ids_list = []
    for i, sample in enumerate(samples):
        print(f'Sample {i+1}: {sample}')
        code = f'Convert the following code from Java to Python: \n\n{sample}'
        input = [{'role': 'user', 'content': code}]
        input_ids = tokenizer.apply_chat_template(input, return_tensors="pt").to('cuda')
        input_ids_list.append(input_ids)

    NOSE(input_ids_list, pretrained_model, tokenizer)
    print('\nNOSE completed!')





if __name__ == '__main__':

    main()
