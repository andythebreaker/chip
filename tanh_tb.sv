`include "tanh.sv"
module tanh_tb;

  // Inputs
  reg signed [31:0] x;
  
  // Outputs
  wire signed [31:0] y;
  
  // Instantiate the tanh module
  tanh dut (
    .x(x),
    .y(y)
  );
  
  // Clock
  reg clk;
  
  // Initialize clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Stimulus
  initial begin
    // Test case 1
    x = 0;
    #10;
    
    // Test case 2
    x = 100;
    #10;
    
    // Test case 3
    x = -100;
    #10;
    
    // Add more test cases as needed
    
x = -0.51*10**8;
    #10;
    x = 0.51*10**8;
    #10;
x = -1.21*10**8;
    #10;
    x = 1.21*10**8;
    #10;
x = -2.41*10**8;
    #10;
    x = 2.41*10**8;
    #10;

    $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("x = %d, y = %d", x, y);
  end

endmodule
