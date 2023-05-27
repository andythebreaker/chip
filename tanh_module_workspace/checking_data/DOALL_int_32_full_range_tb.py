import sys
import subprocess
import os

subprocess.call(['rm', '-rf', '../gen_int_32_full_range_tb.sv'])
subprocess.call(['rm', '-rf', '../gen_int_32_full_range_tb_result.csv'])
subprocess.call(['rm', '-rf', '../int_32_full_range_tb_result.csv'])

with open('../gen_int_32_full_range_tb.sv', 'w') as file:
    file.write('`include "tanh.sv"\nmodule tanh_tb;\nreg signed [31:0] x;\nwire signed [31:0] y;\ntanh dut (.x(x), .y(y));\n\n// Clock\nreg clk;\n\n// Initialize clock\ninitial begin\n    clk = 0;\n    forever #5 clk = ~clk;\nend\n\n// Stimulus\ninitial begin\n')

subprocess.call([sys.executable, 'lox.py'], stdout=open('../gen_int_32_full_range_tb.sv', 'a'))

with open('../gen_int_32_full_range_tb.sv', 'a') as file:
    file.write('#10;\n$finish;\nend\n\n// Monitor\nalways @(posedge clk) begin\n    $display("%d, %d", x, y);\nend\n\nendmodule\n')

# Change directory to the parent directory
os.chdir('..')

# Execute ncverilog command
subprocess.call(['ncverilog', 'tanh.sv'])

# Execute ncverilog command with arguments
#subprocess.call(['ncverilog', 'gen_int_32_full_range_tb.sv', '+access+r'])

# Redirect output to a file
with open('gen_int_32_full_range_tb_result.csv', 'w') as output_file:
    subprocess.call(['ncverilog', 'gen_int_32_full_range_tb.sv', '+access+r'], stdout=output_file)

#import subprocess

# Redirect output to a file
#with open('gen_int_32_full_range_tb_result.csv', 'w') as output_file:
#    subprocess.call(['ncverilog', 'gen_int_32_full_range_tb.sv', '+access+r'], stdout=output_file)

# Read output file
output_lines = []
with open('gen_int_32_full_range_tb_result.csv', 'r') as output_file:
    output_lines = output_file.readlines()

# Remove lines containing 'Simulation complete'
#output_lines = [line for line in output_lines if 'Simulation complete' not in line]

# Find the index of the line containing 'xcelium> run'
run_line_index = -1
for i, line in enumerate(output_lines):
    if 'xcelium> run' in line:
        run_line_index = i
        break

# Remove lines before and after 'xcelium> run'
output_lines = output_lines[run_line_index+2:-1]
#if run_line_index < 0:
#    output_lines = output_lines[:-1]

run_line_index = -1
for i, line in enumerate(output_lines):
    if 'Simulation complete' in line:
        run_line_index = i
        break

output_lines = output_lines[0:run_line_index]

# Write the modified output back to the file
with open('int_32_full_range_tb_result.csv', 'w') as output_file:
    output_file.writelines(output_lines)
