module vmvmb (
input logic signed [31:0] a[0:`size_minus_1(`matrix_size_2)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_2)],
output logic signed [31:0] result[0:`size_minus_1(`matrix_size_2)]
);