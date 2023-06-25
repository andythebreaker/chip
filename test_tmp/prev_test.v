module prev_test (
	clk,
	x,
	prev,
	diff
);
	input wire clk;
	input wire signed [31:0] x;
	output reg signed [31:0] prev;
	output reg signed [31:0] diff;
	wire signed [31:0] state;
	always @(posedge clk) begin
		prev <= x;
		diff <= x - prev;
	end
endmodule
