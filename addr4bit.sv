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

int main_index;//x*y*z, [AQ] 這裡可不可以用 assign 來寫呢？
//TODO 用不同的寫法，讓他跑合成看會合出啥www
logic trigger_prev;

always_ff @( posedge clock || posedge rst ) begin : blockName
    if (rst) begin
        main_index <= 0;
        trigger_prev <= `FALSE;
    end
    else if ((trigger==`TRUE)&&(trigger_prev==`FALSE)) begin
        trigger_prev<=trigger;
        main_index <= main_index + 1;
    end else begin
        trigger_prev<=trigger;
    end 
end

endmodule