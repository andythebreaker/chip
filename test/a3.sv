`include "a1.sv"
`include "a2.sv"
`include "a0.sv"

module a3(
    input logic signed [5:0] x1,
    input logic signed [5:0] y1,
    input logic signed [5:0] x2,
    input logic signed [5:0] y2,
    output logic signed [5:0] z
);

logic signed [5:0] z1;
logic signed [5:0] z2;

a1 a1_inst(
    x1,
    y1,
    z1
);

a2 a2_inst(
    x2,
    y2,
    z2
);


a0 a0_inst(
    z1,
    z2,
    z
);


endmodule;