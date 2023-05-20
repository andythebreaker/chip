module a0(
    input logic signed [5:0] x,
    input logic signed [5:0] y,
    output logic signed [5:0] z
);

assign z = x+y;

endmodule;