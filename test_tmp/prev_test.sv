module prev_test(
    input logic clk,
    //input logic rst,
    input int x,
    output int prev,
    output int diff
    );

int state;

always_ff @(posedge clk /*|| posedge rst*/) begin

//if (rst) begin
  //  state <= 0;
//end else begin
prev <= x;
diff <= x - prev;
//end
end

    endmodule