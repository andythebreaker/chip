`define size_minus_1(x) (x-1)
`define matrix_size_1 5
`define matrix_size_2 400
`define vector_size `matrix_size_1

module vector_mul_vector_genED_M_5_400_V_5 (
input logic signed [31:0] a[0:`size_minus_1(`matrix_size_1)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_1)],
output logic signed [31:0] result[0:`size_minus_1(`matrix_size_1)]
);
assign result[0] = a[0] * ( b[0] / 2147483647 );
assign result[1] = a[1] * ( b[1] / 2147483647 );
assign result[2] = a[2] * ( b[2] / 2147483647 );
assign result[3] = a[3] * ( b[3] / 2147483647 );
assign result[4] = a[4] * ( b[4] / 2147483647 );

endmodule
