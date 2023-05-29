`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1
//`include "tool/B_matrix_times_vector_genED_M_100_400_V_100.sv"
//`include "tool/matrix_times_vector_genED_M_100_400_V_100.sv"
//`include "tool/vector_add_vector_genED_M_100_400_X_400.sv"
`include "vmvmb.sv"
`include "fgio.sv"

module LSTMpe (
input logic signed [31:0] x[0:`size_minus_1(`vector_size)],
input logic signed [31:0] Wx[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] h_prev[0:`size_minus_1(`vector_size)],
input logic signed [31:0] Wh[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] c_prev[0:`size_minus_1(`vector_size)],
//input logic clk,
output logic signed [31:0] c_next[0:`size_minus_1(`vector_size)],
output logic signed [31:0] h_t[0:`size_minus_1(`vector_size)]
);

logic signed [31:0] A[0:`size_minus_1(`matrix_size_2)];

vmvmb vmvmb_dut(
        x,Wx,h_prev,Wh,b,A
    );

fgio fgio_dut(
    c_prev,A,c_next,h_t
    );

endmodule