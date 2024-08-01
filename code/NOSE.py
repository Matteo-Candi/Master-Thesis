from transformers import AutoTokenizer, AutoModelForCausalLM
import torch.nn as nn
import torch
import json
import os



class IdentitySelfAttention(nn.Module):
    def __init__(self, config):
        super().__init__()
        self.config = config

    def forward(self, hidden_states, attention_mask=None, head_mask=None, output_attentions=False, position_ids=None, past_key_value=None, use_cache=False, query_length=None, cache_position=None):

        return hidden_states, None, None


def set_attention_to_identity(model, layer_index):
    # Access the specific layer to be modified
    layer = model.model.layers[layer_index]
    
    # Replace the self-attention layer with the custom identity self-attention layer
    layer.self_attn = IdentitySelfAttention(layer.self_attn.config)
    
    return model


def model_reduction(pretrained_model, S):

    model = pretrained_model

    for idx in S:
        model = set_attention_to_identity(pretrained_model, idx)

    return model


def get_logits(input_ids, model, tokenizer, base=False, max_length=500):

    temperature = 0.1
    eos_token_id = tokenizer.eos_token_id

    all_logits = []

    # Generate tokens manually
    for _ in range(max_length):
        # Get the logits from the model
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


def get_entropy(logits):
    
    logits = torch.cat(logits, dim=0)
    entropy = torch.log2(torch.std(logits.float(), 0)).sum()

    return entropy.item()


def single_step_NOSE(input_ids, pretrained_model, tokenizer, S, filename):

    model = model_reduction(pretrained_model, S)
    base_logits, max_length = get_logits(input_ids, model, tokenizer, base=True)
    base_entropy = get_entropy(base_logits)

    entropy_dict = {}
    num_attention_layers = pretrained_model.config.num_attention_heads

    for i in range(num_attention_layers):

        print(f'      Running layer {i}...')

        if i not in S:
            model = model_reduction(model, [i])
            logits = get_logits(input_ids, model, tokenizer, max_length=max_length)
            entropy = get_entropy(logits)

            entropy_dict[i] = entropy

    transfer_entropy_dict = {layer: base_entropy - entropy for layer, entropy in entropy_dict.items()}
    step_layer = int(min(transfer_entropy_dict, key=transfer_entropy_dict.get))

    step_dict = {
                'S': S + [step_layer],
                'base_entropy': base_entropy,
                'entropy': entropy_dict,
                'transfer_entropy': transfer_entropy_dict,
                }

    step = len(S)

    mose_dict_file = json.load(open(filename, 'r'))
    mose_dict_file[f'step_{step}'] = step_dict
    json.dump(mose_dict_file, open(filename, 'w'))

    print('     ', transfer_entropy_dict)
    print('     Layer to remove:', step_layer)

    return step_layer


def NOSE(input_ids, pretrained_model, tokenizer, max_steps=10):

    filename = 'NOSE_results.json'
    if not os.path.exists(filename):
        json.dump({}, open(filename, 'w'))

    S = []
    for _ in range(max_steps):
        print(f'\nRunning step {len(S)}...')
        step_layer = single_step_NOSE(input_ids, pretrained_model, tokenizer, S, filename)
        S.append(step_layer)

    return 




# Load pre-trained model and tokenizer
tokenizer = AutoTokenizer.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B")
pretrained_model = AutoModelForCausalLM.from_pretrained("m-a-p/OpenCodeInterpreter-DS-6.7B").to('cuda')


# Use as input a code translation from Java to Python of a simple function
code = 'Convert the following code from Java to Python: double triangleArea ( double a , double h ) { return a * h / 2 ; } '

# Apply the chat template to the input code
input = [{'role': 'user', 'content': code}]
input_ids = tokenizer.apply_chat_template(input, return_tensors="pt").to('cuda')




if __name__ == '__main__':

    NOSE(input_ids, pretrained_model, tokenizer)

    print('\nNOSE completed!')
