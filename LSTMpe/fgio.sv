`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1

//`include "../sigmoid_module_workspace/sigmoid.sv"
//`include "../tanh_module_workspace/tanh.sv"
`include "long_non_linear_shape_100_400_sigmoid.sv"
`include "long_non_linear_shape_100_400_tanh.sv"
`include "vector_add_vector_genED_X_100_400_V_100.sv"
`include "vector_mul_vector_genED_M_100_400_V_100.sv"

module fgio (
input logic signed [31:0] c_prev[0:`size_minus_1(`vector_size)],
input logic signed [31:0] fgio_in[0:`size_minus_1(`matrix_size_2)],
//input logic signed [31:0] f_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] g_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] i_i[0:`size_minus_1(`vector_size)],
//input logic signed [31:0] o_i[0:`size_minus_1(`vector_size)],
output logic signed [31:0] c_next[0:`size_minus_1(`vector_size)],
output logic signed [31:0] h_t[0:`size_minus_1(`vector_size)]
);

// define non-linear layer
logic signed [31:0] f[0:`size_minus_1(`vector_size)];
logic signed [31:0] g[0:`size_minus_1(`vector_size)];
logic signed [31:0] i[0:`size_minus_1(`vector_size)];
logic signed [31:0] o[0:`size_minus_1(`vector_size)];

// define of fgio inter connection
logic signed [31:0] a[0:`size_minus_1(`vector_size)];
logic signed [31:0] b[0:`size_minus_1(`vector_size)];
//logic signed [31:0] c[0:`size_minus_1(`vector_size)];
logic signed [31:0] d[0:`size_minus_1(`vector_size)];


// connect non-linear layer
long_non_linear_shape_100_400_sigmoid nl_f(fgio_in[0:`size_minus_1(100)],f);
long_non_linear_shape_100_400_tanh nl_g(fgio_in[0:`size_minus_1(100)],g);
long_non_linear_shape_100_400_sigmoid nl_i(fgio_in[0:`size_minus_1(100)],i);
long_non_linear_shape_100_400_sigmoid nl_o(fgio_in[0:`size_minus_1(100)],o);

// connect fgio inter connection
vector_mul_vector_genED_M_100_400_V_100 mul_a(f,c_prev,a);
vector_mul_vector_genED_M_100_400_V_100 mul_b(g,i,b);
vector_add_vector_genED_X_100_400_V_100 add_c(a,b,c_next);
long_non_linear_shape_100_400_tanh nl_c(c_next,d);
vector_mul_vector_genED_M_100_400_V_100 mul_d(o,d,h_t);
    
endmodule