## Files Usage

- `run.py`: run this file to generate the translations and evaluate them passing as input the model's name selceted to use

    Example of usage
    ``` shell
    python run.py --filename nose_step_5
    ```
    to run the model with the layers selected until the step 5 of the NOSE algorithm setted as (2 * layer_input).


- `NOSE.py`: run this file to execute the NOSE algorithm whit the baseline model. The results will be saved in the file *NOSE_results.json*