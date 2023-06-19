`include "sram_l1cache.sv"

// this part need to be same as the sram you included
`define HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL 8'd6//3*2 for now
`define M1(x) (x-1)
`define M2(x) (x-2)
  /*parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 33 ;
  parameter ADDR_WIDTH = 9 ;*/
//!important!:you must copy above 3 line of code to below, making define of parameter, value must be the same.
`define NUM_WMASKS_ 4
`define DATA_WIDTH_ 33
`define ADDR_WIDTH_ 9

module sram_l1cache_tb;
/*this is the module's i/o which we want to test:
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
    */
    reg clk;
    reg rst_n;
    reg [`M1(ADDR_WIDTH):0] addr;
    reg [`M2(DATA_WIDTH):0] data_in;
    reg we;
    reg csb;
    reg [`M1(NUM_WMASKS):0] wmask;
    wire [`M2(DATA_WIDTH):0] data_out;
    wire data_ready;

    logic signed [7:0] count;

    sram_wrap_l1 uut(
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .data_in(data_in),
        .we(we),
        .wmask(wmask),
        .data_out(data_out),
        .data_ready(data_ready),
        .csb(csb)
    );

initial begin
$fsdbDumpfile("sram_wrap_l1.fsdb");
$fsdbDumpvars("+all");
end

// Clock generation
  always begin
    clk = 0;
    #1;
    clk = 1;
    #1;
  end

  initial begin
count=0;//you must do this to initialize all the stuff, start
rst_n = 1;
csb=1;
we=1;
#2 rst_n = 0;
#2 rst_n = 1;//you must do this to initialize all the stuff, end
#2 addr=`ADDR_WIDTH_'d48;//write command start
#2 wmask=`NUM_WMASKS_'b1111;
#2 data_in=`DATA_WIDTH_'d77;
#2 we=0;
#2 csb=0;
#4 csb=1;//wait for 1 clock
#2 we=1;//write command end
#2 addr=`ADDR_WIDTH_'d49;//write command start
#2 wmask=`NUM_WMASKS_'b1111;
#2 data_in=`DATA_WIDTH_'d1;
#2 we=0;
#2 csb=0;
#4 csb=1;//wait for 1 clock
#2 we=1;//write command end
#2 addr=`ADDR_WIDTH_'d48;//read command start
#2 we=1;
#2 csb=0;
// wait until data_ready is 1 then fetch data_out, also display in command line
#2 while((data_ready==0)&&(count<8'd80)) begin
#1 $display("data_ready is %d",data_ready);
count=count+1;
end
#2 $display("data_out is %d, and the count is %d, data redy %b",data_out,count,data_ready);
#2 csb=1;
#2 we=0;//read command end
#2 $finish;
  end


endmodule