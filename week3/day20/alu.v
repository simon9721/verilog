module alu (
    input wire [3:0] a, b,        // 4-bit inputs
    input wire [2:0] op,          // Operation select
    output reg [3:0] result       // 4-bit output
);
    
    always @(*) begin
        case (op)
            3'b000: result = a + b;   // Addition
            3'b001: result = a - b;   // Subtraction
            3'b010: result = a & b;   // Bitwise AND
            3'b011: result = a | b;   // Bitwise OR
            3'b100: result = a ^ b;   // Bitwise XOR
            default: result = 4'b0000; // Default case
        endcase
    end
endmodule