//`include "systolic_array.v"//不包，由上層呼叫並在上層接線
///////////////////////////////////////////////copy
// this part need to be same as the sram you included
`define HOW_MUCH_CLOCK_TO_WAIT_AFTER_I_SENT_THE_READ_DATA_SIGNAL 8'd6//3*2 for now
`define M1(x) (x-1)
`define M2(x) (x-2)
//!important!:you must copy above 3 line of code to below, making define of parameter, value must be the same.
`define NUM_WMASKS_ 8
`define DATA_WIDTH_ 65
`define ADDR_WIDTH_ 11
///////////////////////////////////////////////copy
`define ZERO4 4'b0000
//https://github.com/andythebreaker/chip/commit/b3ed9ecfa40e1ee5706749b3787abc39b618d4b1#diff-343487a59ed1b863632a3323a521c9c2170e67c71b71ca9d13a57260de026363
`define alpha (for_d+for_b) //這感覺弄不成變數
`define beta (for_a+for_c) //這感覺弄不成變數
`define TRUE 1'b1
`define FALSE 1'b0


parameter CTRL_tiles_size=9;//這東西是怎麼樣也都動不了啦，因為是用來當作array的大小的，所以不能動
parameter CTRL_tiles_size_width = CTRL_tiles_size;
parameter CTRL_tiles_size_height = CTRL_tiles_size;
parameter sram_addr_max=1024;

typedef enum { idle, wait_mem ,write1,
write2,write3,write4,write5,write6,write7,write8,write9,
wait11,wait12,
wait21,wait22,wait31,wait32,wait41,wait42,wait51,wait52,wait61,wait62,wait71,wait72,wait81,wait82,wait91,wait92,} State;


//TODO 勢必是需要打到buffer (sram) 中了
module connect_main_mem_with_pe_array(
  input logic clk,
  input logic rst,
  //TODO CTRL 可以用short啊之類的但反正現在先這樣
  input int CTRL_padding_t_full_img,//1
  input int CTRL_padding_b_full_img,//1
  input int CTRL_padding_l_full_img,//1
  input int CTRL_padding_r_full_img,//1
  input int CTRL_img_w_full,//224
  input int CTRL_img_h_full,//224
  input int CTRL_img_c_full,//3
  input int CTRL_filter_w,//3
  input int CTRL_filter_h,//3
  input logic data_ready_from_mem_addr_redirect,//接mem轉址器
  input logic [3:0] pixel_data;//接mem
  //x,y,z
  output int x,//接mem轉址器
  output int y,//接mem轉址器
  output int z,//接mem轉址器
  output logic data_ready_to_mem_addr_redirect,//接mem轉址器
  output logic [3:0] main_output_img_data_9_to_pe_array[0:`M1(CTRL_tiles_size_height)] //接pe array
  //sram
 output  reg [`M1(ADDR_WIDTH):0] addr;
  output   reg [`M2(DATA_WIDTH):0] data_in;
   output  reg we;
   output  reg csb;
   output  reg [`M1(NUM_WMASKS):0] wmask;
);

State state;


int for_a;//filter width counter
int for_b;//filter height counter
int for_c;//full img width counter
int for_d;//full img height counter
int for_e;//channel counter
int m;//3*3計數器
int n;//9計數器
logic [3:0] reg_9x9 [0:`M1(CTRL_tiles_size_width)][0:`M1(CTRL_tiles_size_height)];//9*9
int sram_addr;

always_ff @(posedge clk, posedge rst) begin
if(rst) begin
  x <= 0;
  y <= 0;
  z <= 0;
  data_ready_to_mem_addr_redirect <= 0;
  for(int i=0;i<CTRL_tiles_size_height;i=i+1) begin//照理來說這個這麼硬是合得出來的吧
    main_output_img_data_9_to_pe_array[i] <= `ZERO4;
  end

state <= idle;
sram_addr<=0;
  //for loop to fsm init.
  for_a <= 0;
  for_b <= 0;
  for_c <= -1*CTRL_padding_l_full_img;//w
  for_d <= -1*CTRL_padding_t_full_img;//h
for_e<=0;
n<=0;
m<=0;
end
else if (state==idle) begin
  for_a <= ((for_a+1) == CTRL_filter_w )?0:for_a+1;
  for_b <= ((for_a+1) == CTRL_filter_w )?((for_b+1) == CTRL_filter_h )?0:(for_b+1):for_b;
  for_c <= ((for_a+1) == CTRL_filter_w )?((for_b+1) == CTRL_filter_h )?((for_c+1) == CTRL_img_w_full )?(-1*CTRL_padding_l_full_img):(for_c+1):for_c:for_c;
  for_d <= ((for_a+1) == CTRL_filter_w )?((for_b+1) == CTRL_filter_h )?((for_c+1) == CTRL_img_w_full )?((for_d+1) == CTRL_img_h_full )?(-1*CTRL_padding_t_full_img):(for_d+1):for_d:for_d:for_d;
  for_e <= ((for_a+1) == CTRL_filter_w )?((for_b+1) == CTRL_filter_h )?((for_c+1) == CTRL_img_w_full )?((for_d+1) == CTRL_img_h_full )?((for_e+1) == CTRL_img_c_full )?0:(for_e+1):for_e:for_e:for_e:for_e;
  m<=((m+1)==`M1(CTRL_tiles_size_height))?0:(m+1);//TODO 9*9這樣好像不是正確的，但反正數字一樣，隨便啦www
n<=((m+1)==`M1(CTRL_tiles_size_height))?((n+1)==`M1(CTRL_tiles_size_width))?0:(n+1):n;//TODO 2塊
if(`alpha<0||`alpha>=CTRL_img_h_full||`beta<0||`beta>=CTRL_img_w_full)begin
reg_9x9[n][m]<=`ZERO4;
end else begin
x<=`alpha;
y<=`beta;
z<=for_e;
data_ready_to_mem_addr_redirect<=`TRUE;
state<=wait_mem;
end
end else if ((state==wait_mem)&&(data_ready_from_mem_addr_redirect==`TRUE)) begin
reg_9x9[n][m]<=pixel_data[`alpha][`beta];
state<=((n+1==`M1(CTRL_tiles_size_width))&&(m+1==`M1(CTRL_tiles_size_height)))?write1:idle;
end else if (state==wait_mem) begin
//to nothing
end else if (state==write1) begin
//往下13行是做sram寫入的動作
addr <=sram_addr
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait11;
data_in<={28'd0,reg_9x9[][8:0]};//64-36=28
end else if (state==wait11)begin
state<=wait12;
 end else if (state==wait12)begin
state<=idle;
csb<=`TRUE;
we<=`TRUE;
 end 
 
 else begin 
//if come here is error
end
end

endmodule