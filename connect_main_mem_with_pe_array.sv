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
wait21,wait22,wait31,wait32,wait41,wait42,wait51,wait52,wait61,wait62,wait71,wait72,wait81,wait82,wait91,wait92} State;


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

logic [3:0] reg_tri_1 [0:32];
logic [3:0] reg_tri_2 [0:28];
logic [3:0] reg_tri_3 [0:24];
logic [3:0] reg_tri_4 [0:20];
logic [3:0] reg_tri_5 [0:16];
logic [3:0] reg_tri_6 [0:12];
logic [3:0] reg_tri_7 [0:8];
logic [3:0] reg_tri_8 [0:4];

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

//init reg_tri1
for(int i=0;i<33;i=i+1) begin
  reg_tri_1[i]<=0;
end
//init reg_tri2
for(int i=0;i<29;i=i+1) begin
  reg_tri_2[i]<=0;
end
//init reg_tri3
for(int i=0;i<25;i=i+1) begin
  reg_tri_3[i]<=0;
end
//init reg_tri4
for(int i=0;i<21;i=i+1) begin
  reg_tri_4[i]<=0;
end
//init reg_tri5
for(int i=0;i<17;i=i+1) begin
  reg_tri_5[i]<=0;
end
//init reg_tri6
for(int i=0;i<13;i=i+1) begin
  reg_tri_6[i]<=0;
end
//init reg_tri7
for(int i=0;i<9;i=i+1) begin
  reg_tri_7[i]<=0;
end
//init reg_tri8
for(int i=0;i<5;i=i+1) begin
  reg_tri_8[i]<=0;
end

//init sram_addr
sram_addr<=0;
//init reg_9x9
for(int i=0;i<CTRL_tiles_size_width;i=i+1) begin
  for(int j=0;j<CTRL_tiles_size_height;j=j+1) begin
    reg_9x9[i][j]<=0;
  end
end

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
end 

else if (state==write1) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait11;
data_in<={28'd0,reg_tri1,reg_9x9[0][0]};//64-36=28;36-4=32
reg_tri1<={reg_9x9[8][1],reg_9x9[7][2],reg_9x9[6][3],reg_9x9[5][4],reg_9x9[4][5],reg_9x9[3][6],reg_9x9[2][7],reg_9x9[1][8]};
end else if (state==wait11)begin
state<=wait12;
 end else if (state==wait12)begin
state<=write2;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
 else if (state==write2) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait21;
data_in<={28'd0,reg_tri2,reg_9x9[1][0],reg_9x9[0][1]};//64-36=28;36-4*2=28
reg_tri2<={reg_9x9[8][2],reg_9x9[7][3],reg_9x9[6][4],reg_9x9[5][5],reg_9x9[4][6],reg_9x9[3][7],reg_9x9[2][8]};
end else if (state==wait21)begin
state<=wait22;
 end else if (state==wait22)begin
state<=write3;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write3) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait31;
data_in<={28'd0,reg_tri3,reg_9x9[2][0],reg_9x9[1][1],reg_9x9[0][2]};//64-36=28;36-4*3=24
reg_tri3<={reg_9x9[8][3],reg_9x9[7][4],reg_9x9[6][5],reg_9x9[5][6],reg_9x9[4][7],reg_9x9[3][8]};
end else if (state==wait31)begin
state<=wait32;
 end else if (state==wait32)begin
state<=write4;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write4) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait41;
data_in<={28'd0,reg_tri4,reg_9x9[3][0],reg_9x9[2][1],reg_9x9[1][2],reg_9x9[0][3]};//64-36=28;36-4*4=20
reg_tri4<={reg_9x9[8][4],reg_9x9[7][5],reg_9x9[6][6],reg_9x9[5][7],reg_9x9[4][8]};
end else if (state==wait41)begin
state<=wait42;
 end else if (state==wait42)begin
state<=write5;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write5) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait51;
data_in<={28'd0,reg_tri5,reg_9x9[4][0],reg_9x9[3][1],reg_9x9[2][2],reg_9x9[1][3],reg_9x9[0][4]};//64-36=28;36-4*5=20
reg_tri5<={reg_9x9[8][5],reg_9x9[7][6],reg_9x9[6][7],reg_9x9[5][8]};
end else if (state==wait51)begin
state<=wait52;
 end else if (state==wait52)begin
state<=write6;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write6) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait61;
data_in<={28'd0,reg_tri6,reg_9x9[5][0],reg_9x9[4][1],reg_9x9[3][2],reg_9x9[2][3],reg_9x9[1][4],reg_9x9[0][5]};//64-36=28;36-4*6=12
reg_tri6<={reg_9x9[8][6],reg_9x9[7][7],reg_9x9[6][8]};
end else if (state==wait61)begin
state<=wait62;
 end else if (state==wait62)begin
state<=write7;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write7) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait71;
data_in<={28'd0,8'd0,reg_9x9[0][6],reg_9x9[1][5],reg_9x9[2][4],reg_9x9[3][3],reg_9x9[4][2],reg_9x9[5][1],reg_9x9[6][0]};//64-36=28;36-4*7=8
end else if (state==wait71)begin
state<=wait72;
 end else if (state==wait72)begin
state<=write8;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write8) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait81;
data_in<={28'd0,4'd0,reg_9x9[0][7],reg_9x9[1][6],reg_9x9[2][5],reg_9x9[3][4],reg_9x9[4][3],reg_9x9[5][2],reg_9x9[6][1],reg_9x9[7][0]};//64-36=28;36-4*8=4
end else if (state==wait81)begin
state<=wait82;
 end else if (state==wait82)begin
state<=write9;//idle;
csb<=`TRUE;
we<=`TRUE;
 end 
  else if (state==write9) begin
//往下13行是做sram寫入的動作
addr <=sram_addr;
sram_addr<=(sram_addr+1==sram_addr_max)?0:(sram_addr+1);
wmask<=`NUM_WMASKS_'b11111111;
we<=`FALSE;
csb<=`FALSE;
state<=wait91;
data_in<={28'd0,reg_9x9[0][8],reg_9x9[1][7],reg_9x9[2][6],reg_9x9[3][5],reg_9x9[4][4],reg_9x9[5][3],reg_9x9[6][2],reg_9x9[7][1],reg_9x9[8][0]};//64-36=28;36-4*9=0
end else if (state==wait91)begin
state<=wait92;
 end else if (state==wait92)begin
state<=idle;
csb<=`TRUE;
we<=`TRUE;
 end 
 
 else begin 
//if come here is error
end
end

endmodule