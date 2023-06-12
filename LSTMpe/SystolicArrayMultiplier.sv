`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1



module SystolicArrayMultiplier (
  input logic signed [31:0] matrix[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],
  input logic signed [31:0] vector[0:`size_minus_1(`vector_size)],
  input logic signed [31:0] b[0:`size_minus_1(`matrix_size_2)],
  output logic signed [31:0] result[0:`size_minus_1(`matrix_size_2)]

);

  // Define the processing elements (PEs) and accumulators
  logic signed [31:0] pe_output [0:3][0:4][0:99];
  logic signed [31:0] accumulators [0:3][0:4][0:99];
  logic signed [31:0] result_temp [0:399];
  
  // Connect the PEs in the systolic array pattern
  generate
    for (genvar i = 0; i < 4; i++) begin
      for (genvar j = 0; j < 5; j++) begin
        for (genvar k = 0; k < 100; k++) begin
          if (i == 0 && j == 0 && k == 0) begin
            assign pe_output[i][j][k] = matrix[i][k] * vector[k];
          end else if (i == 0 && j == 0) begin
            assign pe_output[i][j][k] = pe_output[i][j][k-1] + matrix[i][k] * vector[k];
          end else if (i == 0) begin
            assign pe_output[i][j][k] = pe_output[i][j-1][k] + matrix[i][k] * vector[k];
          end else begin
            assign pe_output[i][j][k] = pe_output[i-1][j][k] + pe_output[i][j-1][k] + matrix[i][k] * vector[k] - pe_output[i-1][j-1][k];
          end
          always_ff @(posedge clk) begin
            accumulators[i][j][k] <= pe_output[i][j][k];
          end
        end
      end
    end
  endgenerate

  // Perform matrix addition result = matrix * vector + b
  always_comb begin
    for (int i = 0; i < 400; i++) begin
      result_temp[i] = accumulators[i % 4][i / 100][i % 100] + b[i];
    end
  end

  // Output is the result of the matrix addition
  assign result = result_temp;

endmodule
