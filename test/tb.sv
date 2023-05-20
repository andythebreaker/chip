`include "a3.sv"

module tb;

logic signed [5:0] x1;
logic signed [5:0] x2;
logic signed [5:0] x3;
logic signed [5:0] x4;
logic signed [5:0] x5;

a3 a3_dut(x1,x2,x3,x4,x5);

initial begin
        $fsdbDumpfile("astest.fsdb");
        $fsdbDumpvars("+all");
    end

    
initial begin
    #10;
    //======================================
x1=6'd1;
x2=6'd2;
x3=6'd3;
x4=6'd4;
    //======================================
    
    // Apply stimulus
    #10;
    
    // Display the result
    $display("...");
    
    // End simulation
    #10$finish;
  end

endmodule