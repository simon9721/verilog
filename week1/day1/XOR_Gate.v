module xor_gate (
    input wire a,        // Input 1
    input wire b,        // Input 2
    output wire sum      // Output
);

assign sum = a ^ b;     // XOR operation

endmodule