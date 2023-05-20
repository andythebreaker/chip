`define size_minus_1(x) (x-1)
`define matrix_size_1 3
`define matrix_size_2 5
`define vector_size `matrix_size_1

module mxv_TB_2;
  
  // Signals
  logic signed [31:0] matrix[`matrix_size_1][`matrix_size_2];
  logic signed [31:0] vector[`vector_size];
  logic signed [31:0] result[`matrix_size_2];
  
  // Instantiate the DUT
  mxv dut (
    .matrix(matrix),
    .vector(vector),
    .result(result)
  );

  //dump-wave
    initial begin
        $fsdbDumpfile("mm2.fsdb");
        $fsdbDumpvars("+all");
    end
  
  // Test stimulus
  initial begin
    //======================================
matrix[0]='{1,2,3,4,5};
matrix[1]='{6,7,8,9,10};
matrix[2]='{11,12,13,14,15};
vector='{1,2,3};
    //======================================
    
    // Apply stimulus
    #10;
    
    // Display the result
    $display("...");
    
    // End simulation
    #10$finish;
  end
  
endmodule
