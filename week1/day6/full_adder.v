module half_adder (
    input wire a,        // Input A
    input wire b,        // Input B
    output wire sum,     // Sum Output
    output wire carry    // Carry Output
);

// Logic implementation
assign sum = a ^ b;       // XOR operation for Sum
assign carry = a & b;     // AND operation for Carry

endmodule