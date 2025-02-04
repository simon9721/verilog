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

module full_adder (
	input wire A,		// Input A 
	input wire B		// Input B 
	input wire Cin		// Input CarryIn
	output wire S 		// Sum output
	output wire Cout	// CarryOut output
);

// Logic implementation
	wire S1, C1, C2;
	
	half_adder HA1 (.a(A), .b(B), .sum(S1), .carry(C1));
	half_adder HA2 (.a(S1), .b(Cin), .sum(S), .carry(C2));
	assign Cout = C1 | C2;
endmodule