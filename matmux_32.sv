`define size_minus_1(x) (x-1)
`define matrix_size_1 3
`define matrix_size_2 5
`define vector_size `matrix_size_1

module mxv (
  input logic signed [31:0] matrix[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
  input logic signed [31:0] vector[0:`size_minus_1(`vector_size)],
  output logic signed [31:0] result[0:`size_minus_1(`matrix_size_2)]
);

  assign result[0] = matrix[0][0] * vector[0] + matrix[1][0] * vector[1] + matrix[2][0] * vector[2];
  assign result[1] = matrix[0][1] * vector[0] + matrix[1][1] * vector[1] + matrix[2][1] * vector[2];
  assign result[2] = matrix[0][2] * vector[0] + matrix[1][2] * vector[1] + matrix[2][2] * vector[2];
  assign result[3] = matrix[0][3] * vector[0] + matrix[1][3] * vector[1] + matrix[2][3] * vector[2];
  assign result[4] = matrix[0][4] * vector[0] + matrix[1][4] * vector[1] + matrix[2][4] * vector[2];

endmodule
