`include "prev_test.v"
module prev_test_tb;
	// Inputs
	reg clk;
	reg signed [31:0] x;
	
	// Outputs
	wire signed [31:0] prev;
	wire signed [31:0] diff;
	
	// Instantiate the module under test
	prev_test dut (
		.clk(clk),
		.x(x),
		.prev(prev),
		.diff(diff)
	);
	
	// Clock generation
	always begin
		clk = 0;
		#5;
		clk = 1;
		#5;
	end
	
	// Stimulus
	initial begin
		x = 0; // Initial value
		
		// Apply input and check outputs
		#10;
		x = 10;
		#10;
		x = -5;
		#10;
		x = 20;
		#10;
		
		// Add more test cases as needed
		
		// End simulation
		#10;
		$finish;
	end
	
	// Display input and output values
	always @(posedge clk) begin
		$display("Time: %t | x: %d | prev: %d | diff: %d", $time, x, prev, diff);
	end
endmodule
