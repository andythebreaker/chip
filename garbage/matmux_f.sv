module MatrixVectorMultiplier (
  input logic [31:0] matrix[0:2][0:3],
  input logic [31:0] vector[0:3],
  output logic [31:0] result
);

  localparam NUM_ROWS = 3;//$size(matrix);
  localparam NUM_COLS = 4;//$size(matrix[0]);

  logic [31:0] product;

  always_comb begin
    product = 0;
    for (int i = 0; i < NUM_ROWS; i++) begin
      logic [31:0] row_product;
      row_product = 0;
      for (int j = 0; j < NUM_COLS; j++) begin
        row_product += matrix[i][j] * vector[j];
      end
      product += row_product;
    end
  end

  assign result = product;

endmodule
