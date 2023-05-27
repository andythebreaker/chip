`define adj_t 21
module tanh (input logic signed [31:0] x,
             output logic signed [31:0] y);
    
    logic signed [31:0] z;
    
    always @(x) begin
        z = (x>= 0)?x:(32'd0-x);
        if (z <= (0.5 * 10**8)) begin
            //$display("%d case1",z);
            y = x*adj_t;
            end else if (z >= (0.5 * 10**8) && z <= (1.2 * 10**8)) begin
            //$display("%d case2",z);
            y = ((x /2) + (0.25 * 10**8)*((x>= 0)?1:-1))*adj_t;
            end else if (z >= (1.2 * 10**8) && z <= (2.4 * 10**8)) begin
            //$display("%d case3",z);
            y = ((x /8) + (0.7 * 10**8)*((x>= 0)?1:-1))*adj_t;
            end else if (x >= (2.4 * 10**8) && x >= 0) begin
            //$display("%d case4",z);
            y = 32'h7FFFFFFF;
            end else begin
            //$display("%d case5",z);
            y = 32'h80000000;
        end
    end
    
endmodule
