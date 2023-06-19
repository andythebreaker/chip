module Memory32x16_TB;
  // Parameters
  `define addr_width 16
  `define addr_height 65536
  `define mem_width 32
  `define M1(x) (x-1)

  // Inputs
  logic clk;
  logic rst;
  logic [`M1(`addr_width):0] addr;
  logic we;
  logic [`M1(`mem_width):0] data_in;
  
  // Outputs
  logic [`M1(`mem_width):0] data_out;
  
  // Instantiate the module under test
  Memory32x16 dut (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .we(we),
    .data_in(data_in),
    .data_out(data_out)
  );
  
  // Clock generator
  always #5 clk = ~clk;

  initial begin
    $fsdbDumpfile("Memory32x16_TB.fsdb");
    $fsdbDumpvars(0, Memory32x16_TB);
  end
  
  initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    addr = 0;
    we = 0;
    data_in = 0;
    
    // Reset the module
    #10 rst = 0;
    
    // Write data to memory
    #10 addr = 0; we = 1; data_in[3:0] = 4'd0;data_in[7:4] = 4'd1;data_in[11:8] = 4'd2;data_in[15:12] = 4'd3;data_in[19:16] = 4'd4;data_in[23:20] = 4'd5;data_in[27:24] = 4'd6;data_in[31:28] = 4'd7;
    
    // Read data from memory
    #10 addr = 0; we = 0;                         // Read from address 0
    #10
    // Check the expected outputs
    $display("data_out = 0x%h", data_out);         // Display the read data
    
    // Finish the simulation
    #10 $finish;
  end
endmodule
