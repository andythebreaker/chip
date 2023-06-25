/* function info.
input x,y,z which is x,y pixel of image, and z is the channel of image
input trigger, when trigger filps from 0 to 1, the function will start to work
output is the value of pixel, where value is in 4 bits
output data_ready, hold for at least 1 clock cycle when the output is valid
*/
`define M1(x) (x-1)
`define M2(x) (x-2)
`define TRUE 1'b1
`define FALSE 1'b0
`define SPLIT_DATA_IN_MEM_ROW_idx0_start 0
`define SPLIT_DATA_IN_MEM_ROW_idx0_end 3
`define SPLIT_DATA_IN_MEM_ROW_idx1_start 4
`define SPLIT_DATA_IN_MEM_ROW_idx1_end 7
`define SPLIT_DATA_IN_MEM_ROW_idx2_start 8
`define SPLIT_DATA_IN_MEM_ROW_idx2_end 11
`define SPLIT_DATA_IN_MEM_ROW_idx3_start 12
`define SPLIT_DATA_IN_MEM_ROW_idx3_end 15
`define SPLIT_DATA_IN_MEM_ROW_idx4_start 16
`define SPLIT_DATA_IN_MEM_ROW_idx4_end 19
`define SPLIT_DATA_IN_MEM_ROW_idx5_start 20
`define SPLIT_DATA_IN_MEM_ROW_idx5_end 23
`define SPLIT_DATA_IN_MEM_ROW_idx6_start 24
`define SPLIT_DATA_IN_MEM_ROW_idx6_end 27
`define SPLIT_DATA_IN_MEM_ROW_idx7_start 28
`define SPLIT_DATA_IN_MEM_ROW_idx7_end 31
`define SPLIT_DATA_IN_MEM_ROW_idx8_start 32
`define SPLIT_DATA_IN_MEM_ROW_idx8_end 35
`define SPLIT_DATA_IN_MEM_ROW_idx9_start 36
`define SPLIT_DATA_IN_MEM_ROW_idx9_end 39
`define SPLIT_DATA_IN_MEM_ROW_idx10_start 40
`define SPLIT_DATA_IN_MEM_ROW_idx10_end 43
`define SPLIT_DATA_IN_MEM_ROW_idx11_start 44
`define SPLIT_DATA_IN_MEM_ROW_idx11_end 47
`define SPLIT_DATA_IN_MEM_ROW_idx12_start 48
`define SPLIT_DATA_IN_MEM_ROW_idx12_end 51
`define SPLIT_DATA_IN_MEM_ROW_idx13_start 52
`define SPLIT_DATA_IN_MEM_ROW_idx13_end 55
`define SPLIT_DATA_IN_MEM_ROW_idx14_start 56
`define SPLIT_DATA_IN_MEM_ROW_idx14_end 59
`define SPLIT_DATA_IN_MEM_ROW_idx15_start 60
`define SPLIT_DATA_IN_MEM_ROW_idx15_end 63


parameter NUM_WMASKS = 8 ;
parameter DATA_WIDTH = 65 ;
parameter ADDR_WIDTH = 11 ;
parameter NUMBERS_IN_A_ROW_OF_MEM=16;//64/4
typedef enum { idle, wait_mem ,wait_one} State;
module addr4bit(
    input logic clock,
    input logic rst,
    input int x,//connect to cpu
    input int y,//connect to cpu
    input int z,//connect to cpu
    input logic trigger,//connect to cpu
    input logic data_ready_mem,//connect to mem
    input logic [`M2(DATA_WIDTH):0] data_out,//connect to mem
    output logic we,//connect to mem
    output logic csb,//connect to mem
    output logic [3:0] p,//connect to cpu
    output logic data_ready_cpu,//connect to cpu
    output [`M1(ADDR_WIDTH):0] addr//connect to mem
);

//int main_index;//x*y*z, [AQ] 這裡可不可以用 assign 來寫呢？
//TODO 用不同的寫法，讓他跑合成看會合出啥www
logic trigger_prev;
State state;

always_ff @( posedge clock || posedge rst ) begin : blockName
    if (rst) begin
        //main_index <= 0;
        trigger_prev <= `FALSE;
        state <= idle;
        data_ready_cpu<=`FALSE;
    end
    else if ((state==idle)&&((trigger==`TRUE)&&(trigger_prev==`FALSE))) begin
        trigger_prev<=trigger;
        addr <= (x*y*z)/(NUMBERS_IN_A_ROW_OF_MEM);//TODO 會從 lsb 還是 msb 開始放呢？
        we <= `TRUE;
        csb <= `FALSE;
        state <= wait_mem;
    end else if ((state==wait_mem)&&(data_ready_mem==`TRUE)) begin
p<=(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==0)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx0_end:`SPLIT_DATA_IN_MEM_ROW_idx0_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==1)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx1_end:`SPLIT_DATA_IN_MEM_ROW_idx1_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==2)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx2_end:`SPLIT_DATA_IN_MEM_ROW_idx2_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==3)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx3_end:`SPLIT_DATA_IN_MEM_ROW_idx3_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==4)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx4_end:`SPLIT_DATA_IN_MEM_ROW_idx4_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==5)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx5_end:`SPLIT_DATA_IN_MEM_ROW_idx5_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==6)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx6_end:`SPLIT_DATA_IN_MEM_ROW_idx6_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==7)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx7_end:`SPLIT_DATA_IN_MEM_ROW_idx7_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==8)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx8_end:`SPLIT_DATA_IN_MEM_ROW_idx8_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==9)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx9_end:`SPLIT_DATA_IN_MEM_ROW_idx9_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==10)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx10_end:`SPLIT_DATA_IN_MEM_ROW_idx10_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==11)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx11_end:`SPLIT_DATA_IN_MEM_ROW_idx11_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==12)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx12_end:`SPLIT_DATA_IN_MEM_ROW_idx12_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==13)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx13_end:`SPLIT_DATA_IN_MEM_ROW_idx13_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==14)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx14_end:`SPLIT_DATA_IN_MEM_ROW_idx14_start]:
(((x*y*z)%NUMBERS_IN_A_ROW_OF_MEM)==15)?data_out[`SPLIT_DATA_IN_MEM_ROW_idx15_end:`SPLIT_DATA_IN_MEM_ROW_idx15_start]:
4'b0000;//如果落到這裡，代表有問題
csb<=`TRUE;
we<=`FALSE;
state<=wait_one;
data_ready_cpu<=`TRUE;
    end else if ((state==wait_one)) begin
        trigger_prev<=trigger;
        state<=idle;
        data_ready_cpu<=`FALSE;
    end else if ((state==idle)||(state==wait_mem)) begin
        trigger_prev<=trigger;
    end else begin
        // do every thing same as rst
        //main_index <= 0;
        trigger_prev <= `FALSE;
        state <= idle;
        data_ready_cpu<=`FALSE;
    end
end

endmodule