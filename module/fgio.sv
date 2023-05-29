`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1

`include "../sigmoid_module_workspace/sigmoid.sv"
`include "../tanh_module_workspace/tanh.sv"

module fgio (
input logic signed [31:0] c_prev[0:`size_minus_1(`vector_size)],
input logic signed [31:0] fgio_in[0:`size_minus_1(`matrix_size_2)],
//input logic signed [31:0] f_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] g_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] i_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] o_i[0:`size_minus_1(`vector_size)],
output logic signed [31:0] c_next[0:`size_minus_1(`vector_size)],
output logic signed [31:0] h_t[0:`size_minus_1(`vector_size)]
);

sigmoid sigmoid_f()
    
endmodule