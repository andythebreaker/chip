`define addr_width 16
//65536 = 2^16
`define addr_height 65536
`define mem_width 32
`define M1(x) (x-1)

module Memory32x16(
  input  logic        clk,
  input  logic        rst,
  input  logic[`M1(`addr_width):0]  addr,
  input  logic        we,
  input  logic[`M1(`mem_width):0]  data_in,
  output logic[`M1(`mem_width):0]  data_out
);
  
  logic[`M1(`mem_width):0] memory [0:`addr_height];

  always_ff @(posedge clk or posedge rst)
  begin
    if (rst)
    for (int i=0; i<`addr_height; i++) begin
        memory[i]<=0;
    end
    else if (we)
      memory[addr] <= data_in;
  end

  always_comb
  begin
    data_out = memory[addr];
  end
  
endmodule
