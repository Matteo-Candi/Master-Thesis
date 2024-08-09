import paramiko
import ast


def run_code():

    hostname = '20.16.61.207'
    port = 22
    username = 'federicaverna'
    password = 'fverna2024ai!'

    commands = [
        'cd thesis',
        'source thesis_env/bin/activate',
        'cd code',
        'cd training',
        'nohup python run.py --nose_step 0 > output.log 2>&1 &' 
    ]

    # Combine commands into a single command string
    combined_command = ' && '.join(commands)

    try:
        ssh = paramiko.SSHClient()

        # Automatically add the VM's SSH key to the list of known hosts
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # Connect to the VM
        ssh.connect(hostname, port, username, password)

        # Execute the command
        stdin, stdout, stderr = ssh.exec_command(combined_command)

        # Stream the output line by line
        output_lines = []
        for line in iter(stdout.readline, ""):
            print(line, end='')  # Print each line as it comes
            output_lines.append(line)

        # Combine all lines to form the final output
        output = ''.join(output_lines)

    except paramiko.ssh_exception.SSHException as e:
        return 'Error Message: Check your connection with the VM and try again.'

    finally:
        # Close the SSH connection
        ssh.close()

    try:
        # Convert the final output into a Python object
        results = ast.literal_eval(output)
    except (SyntaxError, ValueError) as e:
        return 'Error Message: Failed to parse the output.'

    return results


if __name__ == '__main__':
    results = run_code()
    print("\nFinal Results:")
    print(results)



# CHECK THE STATUS OF THE TRAINING
# cd thesis/code/training 
# tail -f output.log

# KILL THE TRAINING
# ps aux | grep run.py 
# kill (PID)

