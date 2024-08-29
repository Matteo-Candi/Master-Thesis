from transformers.models.llama.modeling_llama import LlamaSdpaAttention
import torch


# Custom class for the attention mechanism
class CustomLlamaSdpaAttention(LlamaSdpaAttention):
    def __init__(self, attention_module, scale_factor, layer_idx):
        super().__init__(attention_module.config, layer_idx)

        self.q_proj = attention_module.q_proj
        self.k_proj = attention_module.k_proj
        self.v_proj = attention_module.v_proj
        self.o_proj = attention_module.o_proj
        self.rotary_emb = attention_module.rotary_emb
        self.layer_idx = layer_idx

        self.scale_factor = scale_factor 

    def forward(self, hidden_states, *args, **kwargs):
        # Perform the standard forward pass to get the attention output
        attn_output, self_attn_weights, present_key_value = super().forward(hidden_states, *args, **kwargs)
        
        # Assuming M is a mask with the same shape as the attention output scaled by a factor related to the epochs
        M = torch.ones_like(attn_output) * self.scale_factor

        # Apply the feature compensation as described
        output = M * attn_output + (2 - M) * hidden_states
        
        return output, self_attn_weights, present_key_value 
     


def freeze_model_parameters(model) -> None:
    for param in model.parameters():
        param.requires_grad = False


def unfreeze_layer_parameters(layer) -> None:
    for param in layer.parameters():
        param.requires_grad = True


def set_mlp_trainable(layer)-> None:
    '''
    Set all the parameters of the layer except for the attention weights to be trainable
    '''

    unfreeze_layer_parameters(layer.mlp)
    unfreeze_layer_parameters(layer.post_attention_layernorm)
    

def customize_self_attention(layer, scale_factor, layer_idx)-> None:
    '''
    Overwrite the self attention layer with a custom implementationsetting the same weights
    '''
    layer.self_attn = CustomLlamaSdpaAttention(layer.self_attn, scale_factor, layer_idx)


def customize_decoder_layer(model, S, scale_factor)-> None:
    '''
    Customize the attention mechanism of the decoder layer and set trainable just the MLP part
    '''

    for s in S:

        decoder_layer = model.model.layers[s]

        customize_self_attention(decoder_layer, scale_factor, s)
        set_mlp_trainable(decoder_layer)



def customize_model(model, S, scale_factor)-> None:
    '''
    Apply the custom layer to all the decoder layers with index in S
    '''

    freeze_model_parameters(model)
    customize_decoder_layer(model, S, scale_factor)