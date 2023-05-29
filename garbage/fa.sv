module IEEE754FloatAdder (
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] sum,
  output reg carry_out,
  output reg overflow
);
  
  always @(*) begin
    // Extracting sign, exponent, and mantissa from inputs
    bit sign_a = a[31];
    bit sign_b = b[31];
    bit exponent_a [7:0] = a[30:23];
    bit exponent_b [7:0] = b[30:23];
    bit mantissa_a [22:0] = a[22:0];
    bit mantissa_b [22:0] = b[22:0];
    
    // Shifting mantissas to align exponents
    bit [23:0] shifted_mantissa_a = {1'b1, mantissa_a} << 1;
    bit [23:0] shifted_mantissa_b = {1'b1, mantissa_b} << 1;
    
    // Determining the larger exponent
    bit [7:0] larger_exponent;
    bit [23:0] larger_mantissa;
    
    if (exponent_a > exponent_b) begin
      larger_exponent = exponent_a;
      larger_mantissa = shifted_mantissa_a;
    end else begin
      larger_exponent = exponent_b;
      larger_mantissa = shifted_mantissa_b;
    end
    
    // Normalizing the smaller number
    bit [23:0] normalized_mantissa;
    bit [7:0] smaller_exponent;
    
    if (exponent_a > exponent_b) begin
      normalized_mantissa = shifted_mantissa_b >> (exponent_a - exponent_b);
      smaller_exponent = exponent_a;
    end else begin
      normalized_mantissa = shifted_mantissa_a >> (exponent_b - exponent_a);
      smaller_exponent = exponent_b;
    end
    
    // Adding the mantissas
    bit [23:0] sum_mantissa;
    bit carry;
    bit overflow;
    bit [24:0] temp_sum;
    
    temp_sum = normalized_mantissa + larger_mantissa;
    carry = temp_sum[24];
    sum_mantissa = temp_sum[23:0];
    carry_out = carry;
    
    // Adjusting the sum
    if (carry) begin
      sum = {larger_exponent + 1, sum_mantissa[22:0]};
      overflow = 1;
    end else begin
      sum = {larger_exponent, sum_mantissa[22:0]};
      overflow = 0;
    end
    
    // Handling sign
    if (sign_a != sign_b) begin
      sum[31] = larger_exponent[7];
    end else begin
      sum[31] = sign_a;
    end
  end
endmodule
