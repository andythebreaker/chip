`define size_minus_1(x) (x-1)
`define matrix_size_1 100
`define matrix_size_2 400
`define vector_size `matrix_size_1

module vector_mul_vector_genED_M_100_400_V_100 (
input logic signed [31:0] a[0:`size_minus_1(`matrix_size_1)],
input logic signed [31:0] b[0:`size_minus_1(`matrix_size_1)],
output logic signed [31:0] result[0:`size_minus_1(`matrix_size_1)]
);
assign result[0] = ( a[0] / 50000000 ) * ( b[0] / 43 );
assign result[1] = ( a[1] / 50000000 ) * ( b[1] / 43 );
assign result[2] = ( a[2] / 50000000 ) * ( b[2] / 43 );
assign result[3] = ( a[3] / 50000000 ) * ( b[3] / 43 );
assign result[4] = ( a[4] / 50000000 ) * ( b[4] / 43 );
assign result[5] = ( a[5] / 50000000 ) * ( b[5] / 43 );
assign result[6] = ( a[6] / 50000000 ) * ( b[6] / 43 );
assign result[7] = ( a[7] / 50000000 ) * ( b[7] / 43 );
assign result[8] = ( a[8] / 50000000 ) * ( b[8] / 43 );
assign result[9] = ( a[9] / 50000000 ) * ( b[9] / 43 );
assign result[10] = ( a[10] / 50000000 ) * ( b[10] / 43 );
assign result[11] = ( a[11] / 50000000 ) * ( b[11] / 43 );
assign result[12] = ( a[12] / 50000000 ) * ( b[12] / 43 );
assign result[13] = ( a[13] / 50000000 ) * ( b[13] / 43 );
assign result[14] = ( a[14] / 50000000 ) * ( b[14] / 43 );
assign result[15] = ( a[15] / 50000000 ) * ( b[15] / 43 );
assign result[16] = ( a[16] / 50000000 ) * ( b[16] / 43 );
assign result[17] = ( a[17] / 50000000 ) * ( b[17] / 43 );
assign result[18] = ( a[18] / 50000000 ) * ( b[18] / 43 );
assign result[19] = ( a[19] / 50000000 ) * ( b[19] / 43 );
assign result[20] = ( a[20] / 50000000 ) * ( b[20] / 43 );
assign result[21] = ( a[21] / 50000000 ) * ( b[21] / 43 );
assign result[22] = ( a[22] / 50000000 ) * ( b[22] / 43 );
assign result[23] = ( a[23] / 50000000 ) * ( b[23] / 43 );
assign result[24] = ( a[24] / 50000000 ) * ( b[24] / 43 );
assign result[25] = ( a[25] / 50000000 ) * ( b[25] / 43 );
assign result[26] = ( a[26] / 50000000 ) * ( b[26] / 43 );
assign result[27] = ( a[27] / 50000000 ) * ( b[27] / 43 );
assign result[28] = ( a[28] / 50000000 ) * ( b[28] / 43 );
assign result[29] = ( a[29] / 50000000 ) * ( b[29] / 43 );
assign result[30] = ( a[30] / 50000000 ) * ( b[30] / 43 );
assign result[31] = ( a[31] / 50000000 ) * ( b[31] / 43 );
assign result[32] = ( a[32] / 50000000 ) * ( b[32] / 43 );
assign result[33] = ( a[33] / 50000000 ) * ( b[33] / 43 );
assign result[34] = ( a[34] / 50000000 ) * ( b[34] / 43 );
assign result[35] = ( a[35] / 50000000 ) * ( b[35] / 43 );
assign result[36] = ( a[36] / 50000000 ) * ( b[36] / 43 );
assign result[37] = ( a[37] / 50000000 ) * ( b[37] / 43 );
assign result[38] = ( a[38] / 50000000 ) * ( b[38] / 43 );
assign result[39] = ( a[39] / 50000000 ) * ( b[39] / 43 );
assign result[40] = ( a[40] / 50000000 ) * ( b[40] / 43 );
assign result[41] = ( a[41] / 50000000 ) * ( b[41] / 43 );
assign result[42] = ( a[42] / 50000000 ) * ( b[42] / 43 );
assign result[43] = ( a[43] / 50000000 ) * ( b[43] / 43 );
assign result[44] = ( a[44] / 50000000 ) * ( b[44] / 43 );
assign result[45] = ( a[45] / 50000000 ) * ( b[45] / 43 );
assign result[46] = ( a[46] / 50000000 ) * ( b[46] / 43 );
assign result[47] = ( a[47] / 50000000 ) * ( b[47] / 43 );
assign result[48] = ( a[48] / 50000000 ) * ( b[48] / 43 );
assign result[49] = ( a[49] / 50000000 ) * ( b[49] / 43 );
assign result[50] = ( a[50] / 50000000 ) * ( b[50] / 43 );
assign result[51] = ( a[51] / 50000000 ) * ( b[51] / 43 );
assign result[52] = ( a[52] / 50000000 ) * ( b[52] / 43 );
assign result[53] = ( a[53] / 50000000 ) * ( b[53] / 43 );
assign result[54] = ( a[54] / 50000000 ) * ( b[54] / 43 );
assign result[55] = ( a[55] / 50000000 ) * ( b[55] / 43 );
assign result[56] = ( a[56] / 50000000 ) * ( b[56] / 43 );
assign result[57] = ( a[57] / 50000000 ) * ( b[57] / 43 );
assign result[58] = ( a[58] / 50000000 ) * ( b[58] / 43 );
assign result[59] = ( a[59] / 50000000 ) * ( b[59] / 43 );
assign result[60] = ( a[60] / 50000000 ) * ( b[60] / 43 );
assign result[61] = ( a[61] / 50000000 ) * ( b[61] / 43 );
assign result[62] = ( a[62] / 50000000 ) * ( b[62] / 43 );
assign result[63] = ( a[63] / 50000000 ) * ( b[63] / 43 );
assign result[64] = ( a[64] / 50000000 ) * ( b[64] / 43 );
assign result[65] = ( a[65] / 50000000 ) * ( b[65] / 43 );
assign result[66] = ( a[66] / 50000000 ) * ( b[66] / 43 );
assign result[67] = ( a[67] / 50000000 ) * ( b[67] / 43 );
assign result[68] = ( a[68] / 50000000 ) * ( b[68] / 43 );
assign result[69] = ( a[69] / 50000000 ) * ( b[69] / 43 );
assign result[70] = ( a[70] / 50000000 ) * ( b[70] / 43 );
assign result[71] = ( a[71] / 50000000 ) * ( b[71] / 43 );
assign result[72] = ( a[72] / 50000000 ) * ( b[72] / 43 );
assign result[73] = ( a[73] / 50000000 ) * ( b[73] / 43 );
assign result[74] = ( a[74] / 50000000 ) * ( b[74] / 43 );
assign result[75] = ( a[75] / 50000000 ) * ( b[75] / 43 );
assign result[76] = ( a[76] / 50000000 ) * ( b[76] / 43 );
assign result[77] = ( a[77] / 50000000 ) * ( b[77] / 43 );
assign result[78] = ( a[78] / 50000000 ) * ( b[78] / 43 );
assign result[79] = ( a[79] / 50000000 ) * ( b[79] / 43 );
assign result[80] = ( a[80] / 50000000 ) * ( b[80] / 43 );
assign result[81] = ( a[81] / 50000000 ) * ( b[81] / 43 );
assign result[82] = ( a[82] / 50000000 ) * ( b[82] / 43 );
assign result[83] = ( a[83] / 50000000 ) * ( b[83] / 43 );
assign result[84] = ( a[84] / 50000000 ) * ( b[84] / 43 );
assign result[85] = ( a[85] / 50000000 ) * ( b[85] / 43 );
assign result[86] = ( a[86] / 50000000 ) * ( b[86] / 43 );
assign result[87] = ( a[87] / 50000000 ) * ( b[87] / 43 );
assign result[88] = ( a[88] / 50000000 ) * ( b[88] / 43 );
assign result[89] = ( a[89] / 50000000 ) * ( b[89] / 43 );
assign result[90] = ( a[90] / 50000000 ) * ( b[90] / 43 );
assign result[91] = ( a[91] / 50000000 ) * ( b[91] / 43 );
assign result[92] = ( a[92] / 50000000 ) * ( b[92] / 43 );
assign result[93] = ( a[93] / 50000000 ) * ( b[93] / 43 );
assign result[94] = ( a[94] / 50000000 ) * ( b[94] / 43 );
assign result[95] = ( a[95] / 50000000 ) * ( b[95] / 43 );
assign result[96] = ( a[96] / 50000000 ) * ( b[96] / 43 );
assign result[97] = ( a[97] / 50000000 ) * ( b[97] / 43 );
assign result[98] = ( a[98] / 50000000 ) * ( b[98] / 43 );
assign result[99] = ( a[99] / 50000000 ) * ( b[99] / 43 );

endmodule
