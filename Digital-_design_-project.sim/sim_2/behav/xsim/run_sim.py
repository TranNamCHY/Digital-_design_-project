import subprocess
import random
import os
import shutil

mem_file = r'C:/Users/admin/Desktop/project/Digital-_design_-project/test.dat'
CREDBG    = '\33[41m'
CYELLOWBG = '\33[43m'
CRED    = '\33[31m'
CGREEN  = '\33[32m'
ENDC = '\033[0m'

num_test = 3
log = False

def main() -> None:
    num_pass = 0
    for test_index in range(num_test):
        cleanup_simulation() # remove old file
        mem = generate_test_mem(mem_file) # create memory file with random data
        stdout = run_vivado_cmd(log) # run vivado testbench simulation
        actual_result = extract_result_from_stdout(stdout) # get actual result from simulation
        expected_result, min_index, max_index = calculate_max_diff(mem) # calculate expected result, get index of max value and min value

        print(f'--------- Test case #{test_index + 1} ---------')
        print_mem_with_max_and_min(mem, min_index, max_index)
        print(f'Min = {mem[min_index]}')
        print(f'Max = {mem[max_index]}')
        print(f'Actual result (from VHDL) = {actual_result}')
        print(f'Expected result (from Python) = {expected_result}')
        if actual_result == expected_result: num_pass += 1

    if num_pass == num_test:
        msg = CGREEN + f"{num_test} test case has passed!" + ENDC + "🎉"
    else: 
        msg = CRED + f"{num_test - num_pass}/{num_test} test case has failed!" + ENDC + "❌"
    print(msg)
    

def run_vivado_cmd(log: bool) -> list[bytes]:
    proc = subprocess.run(['.\\compile.bat'], stdout=subprocess.PIPE) # compile testbench
    if log: print(proc.stdout)
    proc = subprocess.run(['.\\elaborate.bat'], stdout=subprocess.PIPE)
    if log: print(proc.stdout)
    proc = subprocess.Popen(['.\\simulate.bat'], shell=True, # run simulation
                            stderr=subprocess.PIPE, 
                            stdin=subprocess.PIPE, 
                            stdout=subprocess.PIPE)
    proc.stdin.write('run 24000ns\n'.encode('utf-8')) # run in 24000ns -> make sure it will be done
    proc.stdin.flush()
    proc.stdin.write('close_sim\n'.encode('utf-8')) # close simulation
    proc.stdin.flush()
    proc.stdin.write('exit\n'.encode('utf-8')) # exit vsim
    proc.stdin.flush()
    stdout = proc.stdout.readlines() # get stdout from cmd
    if log: print(stdout)
    return stdout

def extract_result_from_stdout(stdout: list[bytes]):
    for line in stdout:
        line = line.decode('utf-8')
        if line.startswith('Note: Result = '):
            result = get_number_from_string(line)
            return result
        
def generate_test_mem(file_name: str) -> list[int]:
    mem = []
    with open(file_name, "w+") as file:
        lower_limit = random.randint(-128, 127)
        upper_limit = random.randint(lower_limit, 127)
        for _ in range(256):
            random_value = random.randint(lower_limit, upper_limit)
            mem.append(random_value)
            file.write(f"{random_value}\n")
    return mem

def calculate_max_diff(mem: list[int]) -> tuple[int, int, int]:
    max = -128
    min = 127
    max_index = -1
    min_index = -1
    for index, value in enumerate(mem):
        if value < min:
            min = value
            min_index = index
        if value > max: 
            max = value
            max_index = index
    return max - min, min_index, max_index

def print_mem_with_max_and_min(mem: list[int], min_index: int, max_index: int) -> None:
    print('Memory data:')
    min_highlighted = False # make sure just one min value being highlighted
    max_highlighted = False # make sure just one max value being highlighted
    num_row = 16
    num_col = 16
    for i in range(num_row):
        print(f'#{(i * num_col):<3}: ', end='')
        for j in range(num_col):
            index = i * num_col + j
            color_code = ''
            if (index == min_index) and (not min_highlighted):
                color_code = CYELLOWBG
                min_highlighted = True
            elif (index == max_index) and (not max_highlighted):
                color_code = CREDBG
                max_highlighted = True
            endc = ENDC if color_code != '' else ''
            space = 7
            print(f'{(color_code + str(mem[index]) + endc)}' + (' ' * (space - len(str(mem[index])))), end='')
        print('', end='\n')

def cleanup_simulation() -> None:
    files = ['./compile.log', './elaborate.log', './simulate.log', 'xvhdl.log', './test.dat']
    for file in files:
        if os.path.isfile(file):
            os.remove(file)
    shutil.rmtree('./xsim.dir')


def get_number_from_string(s: str) -> int:
    return [int(t) for t in s.split() if t.isdigit()][0]

if __name__ == "__main__":
    main()