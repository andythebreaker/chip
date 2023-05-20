`define size_minus_1(x) (x-1)
`define matrix_size_1 3
`define matrix_size_2 5
`define vector_size `matrix_size_1

module mxv_TB_2;
  
  // Signals
  logic signed [31:0] a[`matrix_size_2];
  logic signed [31:0] result[`matrix_size_2];
  logic signed [31:0] b[`matrix_size_2];
  
  // Instantiate the DUT
  matmux_32 dut (
    .a(a),
    .result(result),
    .b(b)
  );

  //dump-wave
    initial begin
        $fsdbDumpfile("mm2.fsdb");
        $fsdbDumpvars("+all");
    end
  
  // Test stimulus
  initial begin
    //======================================
a='{1,2,3,4,5};
b='{6,7,8,9,10};
    //======================================
    
    // Apply stimulus
    #10;
    
    // Display the result
    $display("...");
    
    // End simulation
    #10$finish;
  end
  
endmodule
