`include "../vector_mul_vector_genED_M_5_400_V_5.sv"
`define size_minus_1(x) (x-1)
`define matrix_size_1 5
`define matrix_size_2 400
`define vector_size `matrix_size_1

module tb;
    
logic signed [31:0] a[0:`size_minus_1(`matrix_size_1)];
logic signed [31:0] b[0:`size_minus_1(`matrix_size_1)];
logic signed [31:0] c[0:`size_minus_1(`matrix_size_1)];

vector_mul_vector_genED_M_5_400_V_5 dut (a,b,c);

initial begin
        $fsdbDumpfile("tb_6data.fsdb");
        $fsdbDumpvars("+all");
    end
    initial begin
    #10;

a='{1030792151 , 1030792151 , 1030792151 , 1030792151 , 1030792151};
b='{1653562408, 1653562408, 1653562408, 1653562408, 1653562408};

#10$display("EOF");
    #10$finish;
    end
    endmodule