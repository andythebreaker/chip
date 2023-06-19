/* this code use sky130
 * this is the sram framwork https://github.com/VLSIDA/OpenRAM
 * this is the sram we used inside https://github.com/VLSIDA/openram_testchip
 * you need to download :
 https://raw.githubusercontent.com/VLSIDA/openram_testchip/main/verilog/rtl/sky130_sram_4kbyte_1rw_32x1024_8.v
 or
 https://raw.githubusercontent.com/VLSIDA/openram_testchip/main/verilog/rtl/sky130_sram_2kbyte_1rw_32x512_8.v
 or
 https://raw.githubusercontent.com/VLSIDA/openram_testchip/main/verilog/rtl/sky130_sram_1kbyte_1rw_32x256_8.v
    
    * and put it in the same folder of this code

==========================================================
author : andythebreaker
date : 2023/06/19
abstract : wrap the sram to make function -> when data is available (@ read stage) , flip the data_redy signal up (for one cycle)
and the data will be there for every instead of outputing "XXXXXXXX" (which is how 'VLSIDA' did)
==========================================================
*/
`include "sky130_sram_1kbyte_1rw_32x256_8.v"
`define HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL 8'd6//3*2 for now
`define M1(x) (x-1)
`define M2(x) (x-2)

// this part need to be same as the sram you included
  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 33 ;
  parameter ADDR_WIDTH = 9 ;

module sram_wrap_l1(
    input clk,
    input rst_n,
    input [`M1(ADDR_WIDTH):0] addr,
    input [`M2(DATA_WIDTH):0] data_in,
    input we,
    input [`M1(NUM_WMASKS):0] wmask,
    output reg [`M2(DATA_WIDTH):0] data_out,
    output reg data_ready
    );
    
    wire [`M2(DATA_WIDTH):0] data_out_temp;
    wire data_ready_temp;
    reg KEEP_ZERO_spare_wen0;//i think we don't ever need to access or write bit 32
    reg KEEP_ZERO_csb0;//if we have muit sram on the same bus, then we might need this to be fliped up or down, but it is not the case now
    logic signed [7:0] fsm_state;//256
reg prev_we;

    sky130_sram_1kbyte_1rw_32x256_8 sram_1rw_32x256_8_inst(//clk0,csb0,web0,wmask0,spare_wen0,addr0,din0,dout0
        .clk0(clk),
        .csb0(KEEP_ZERO_csb0),
        .web0(we),
        .wmask0(wmask),
        .spare_wen0(KEEP_ZERO_spare_wen0),
        .addr0(addr),
        .din0(data_in),
        .dout0(data_out_temp)
        );
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            data_out <= 32'b0;
            data_ready <= 1'b0;
            KEEP_ZERO_spare_wen0<=1'b0;
            KEEP_ZERO_csb0<=1'b0;
            fsm_state<=8'd0;
        end
        else begin

if(we&&(prev_we!=we))begin
fsm_state<=8'd1;
end
prev_we<=we;
case (fsm_state)
            `HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL : data_out <= data_out_temp;
            (`HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL+8'd1) : data_ready <= data_ready_temp;
 endcase
case (fsm_state)
      8'd0: fsm_state <= 8'd0;
      8'd1: fsm_state <= fsm_state+8'd1;
      8'd2: fsm_state <= fsm_state+8'd1;
      8'd3: fsm_state <= fsm_state+8'd1;
      8'd4: fsm_state <= fsm_state+8'd1;
      8'd5: fsm_state <= fsm_state+8'd1;
      `HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL : fsm_state <= fsm_state+8'd1;
      (`HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL+8'd1) : fsm_state <= 8'd0;
      default: fsm_state = 8'd0;
    endcase
        end
    end
    endmodule