import sys
import subprocess

with open('../gen_int_32_full_range_tb.sv', 'w') as file:
    file.write('`include "tanh.sv"\nmodule tanh_tb;\nreg signed [31:0] x;\nwire signed [31:0] y;\ntanh dut (.x(x), .y(y));\n\n// Clock\nreg clk;\n\n// Initialize clock\ninitial begin\n    clk = 0;\n    forever #5 clk = ~clk;\nend\n\n// Stimulus\ninitial begin\n')

subprocess.call([sys.executable, 'lox.py'], stdout=open('../gen_int_32_full_range_tb.sv', 'a'))

with open('../gen_int_32_full_range_tb.sv', 'a') as file:
    file.write('#10;\n$finish;\nend\n\n// Monitor\nalways @(posedge clk) begin\n    $display("x=%d, y=%d", x, y);\nend\n\nendmodule\n')