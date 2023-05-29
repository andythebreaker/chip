`define size_minus_1(x) (x-1)
`define matrix_size_1 3
`define matrix_size_2 5
`define vector_size `matrix_size_1

module vector_add_vector_genED_M_3_5_V_3 (
input logic signed [31:0] a[0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_2)],
output logic signed [31:0] result[0:`size_minus_1(`matrix_size_2)]
);
assign result[0] = a[0] + b[0];
assign result[1] = a[1] + b[1];
assign result[2] = a[2] + b[2];
assign result[3] = a[3] + b[3];
assign result[4] = a[4] + b[4];

endmodule
