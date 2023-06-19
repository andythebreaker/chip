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
    #10 addr = 0; we = 1; data_in = 32'h12345678;  // Write 0x12345678 to address 0
    #10 addr = 1; we = 1; data_in = 32'h87654321;  // Write 0x87654321 to address 1
    #10 addr = 2; we = 1; data_in = 32'hdeadbeef;  // Write 0xdeadbeef to address 2
    

    
    // Finish the simulation
    #10 $finish;
  end
endmodule
