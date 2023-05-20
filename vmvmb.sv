`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1
`include "tool/B_matrix_times_vector_genED_M_100_400_V_100.sv"
`include "tool/matrix_times_vector_genED_M_100_400_V_100.sv"
`include "tool/vector_add_vector_genED_M_100_400_V_100.sv"

module vmvmb (
input logic signed [31:0] x[0:`size_minus_1(`matrix_size_1)],
input logic signed [31:0] Wx[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] h_prev[0:`size_minus_1(`matrix_size_1)],
input logic signed [31:0] Wh[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_2)],
//input logic clk,
output logic signed [31:0] A[0:`size_minus_1(`matrix_size_2)]
);

logic signed [31:0] mtv_out[0:`size_minus_1(`matrix_size_2)];
logic signed [31:0] bmtv_out[0:`size_minus_1(`matrix_size_2)];

matrix_times_vector_genED_M_100_400_V_100 mtv(
    Wx,x,mtv_out
);

B_matrix_times_vector_genED_M_100_400_V_100 bmtv(
    Wh,h_prev,b,bmtv_out
);

vector_add_vector_genED_M_100_400_V_100 vav(
mtv_out,bmtv_out,A
);

//always @(posedge clk) begin
    
//end

endmodule