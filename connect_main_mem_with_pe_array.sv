module array_processing;
  parameter SIZE = 224;
  
  reg signed [31:0] x [0:SIZE-1][0:SIZE-1];
  reg [31:0] n, m;
  
  integer d, c, b, a, alpha, beta;
  reg signed [31:0] y [0:2][0:2];
  
  always @* begin
    for (d = -1; d < SIZE; d = d + 1) begin
      for (c = -1; c < SIZE; c = c + 1) begin
        for (b = 0; b < 3; b = b + 1) begin
          for (a = 0; a < 3; a = a + 1) begin
            alpha = d + b;
            beta = c + a;
            if (alpha < 0 || alpha >= SIZE || beta < 0 || beta >= SIZE) begin
              y[b][a] = 0;
            end
            else begin
              y[b][a] = x[alpha][beta];
            end
            m = (m == 9) ? 0 : (m + 1);
          end
        end
        n = n + 1;
      end
    end
  end
  
  initial begin
    // Initialize x array with values
    
    // initialize the x array with 224x224 integer values
//=============TB=================
//================================
    
    // Reset n and m
    n = 0;
    m = 0;
    
    // Start simulation
    #10;
    $display("n = %d, m = %d", n, m);
    // Display the values of n and m after simulation
    
    // display the values of n and m after the simulation
    // 
    // $display("n = %d, m = %d", n, m);
    
    // Display the values of y array
    
    // display the values of the y array
    // 
    // $display("y[0][0] = %d, y[0][1] = %d, ...", y[0][0], y[0][1], ...);
    
    $finish;
  end
  
endmodule
