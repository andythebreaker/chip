module MatrixVectorMultiplier_TB;
  
  // Parameters
  localparam NUM_ROWS = 3;
  localparam NUM_COLS = 4;
  
  // Signals
  logic [31:0] matrix[NUM_ROWS][NUM_COLS];
  logic [31:0] vector[NUM_COLS];
  logic [31:0] result;
  
  // Instantiate the DUT
  MatrixVectorMultiplier dut (
    .matrix(matrix),
    .vector(vector),
    .result(result)
  );

  //dump-wave
    initial begin
        $fsdbDumpfile("MatrixVectorMultiplier.fsdb");
        $fsdbDumpvars("+all");
    end
  
  // Test stimulus
  initial begin
    // Initialize matrix
    matrix[0] = '{32'h3f800000, 32'h40000000, 32'h40400000, 32'h40800000};
    matrix[1] = '{32'h40a00000, 32'h40c00000, 32'h40e00000, 32'h41000000};
    matrix[2] = '{32'h41100000, 32'h41200000, 32'h41300000, 32'h41400000};
    
    // Initialize vector
    vector = '{32'h41f00000, 32'h41e00000, 32'h41d00000, 32'h41c00000};
    
    // Apply stimulus
    #10;
    
    // Display the result
    $display("Result: %f", result);
    
    // End simulation
    $finish;
  end
  
endmodule
