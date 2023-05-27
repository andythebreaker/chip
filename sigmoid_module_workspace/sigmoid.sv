`define adj_t 21
`define max_of_int32 2147483647
`define min_of_int32 -2147483648

`define const_1  0.01129
`define const_2  0.06248 
`define const_3  0.02943
`define const_4  0.13404 
`define const_5  0.07177
`define const_6  0.25602
`define const_7 0.14973
`define const_8  0.41285 
`define const_9  0.23105
`define const_10  0.49653 
`define const_11  0.23105
`define const_12  0.50346
`define const_13  0.14973
`define const_14  0.58714 
`define const_15  0.07177
`define const_16  0.74097 
`define const_17  0.02943
`define const_18  0.86595
`define const_19  0.01129
`define const_20  0.93751

`define adj_t 10

`define ctrl ((`max_of_int32/2)/5)

module sigmoid (input logic signed [31:0] x,
             output logic signed [31:0] y);
        
    always @(x) begin
        if (x <= -5*`ctrl) begin
            y = 0;
        end
        else if (x >= -5*`ctrl && x <= -4*`ctrl) begin
            y = (`const_1*x + `const_2*`ctrl) * `adj_t;
        end
        else if (x >= -4*`ctrl && x <= -3*`ctrl) begin
            y = (`const_3*x + `const_4*`ctrl) * `adj_t;
        end
        else if (x >= -3*`ctrl && x <= -2*`ctrl) begin
            y = (`const_5*x + `const_6*`ctrl) * `adj_t;
        end
        else if (x >= -2*`ctrl && x <= -1*`ctrl) begin
            y = (`const_7*x + `const_8*`ctrl) * `adj_t;
        end
        else if (x >= -1*`ctrl && x <= 0*`ctrl) begin
            y = (`const_9*x + `const_10*`ctrl) * `adj_t;
        end
        else if (x >= 0*`ctrl && x <= 1*`ctrl) begin
            y = (`const_11*x + `const_12*`ctrl) * `adj_t;
        end
        else if (x >= 1*`ctrl && x <= 2*`ctrl) begin
            y = (`const_13*x + `const_14*`ctrl) * `adj_t;
        end
        else if (x >= 2*`ctrl && x <= 3*`ctrl) begin
            y = (`const_15*x + `const_16*`ctrl) * `adj_t;
        end
        else if (x >= 3*`ctrl && x <= 4*`ctrl) begin
            y = (`const_17*x + `const_18*`ctrl) * `adj_t;
        end
        else if (x >= 4*`ctrl && x <= 5*`ctrl) begin
            y = (`const_19*x + `const_20*`ctrl) * `adj_t;
        end
        else begin
            y = `max_of_int32;
        end
            end
    
endmodule
