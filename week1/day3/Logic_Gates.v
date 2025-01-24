// Day 3: Implement Basic Logic Gates
// Task: Code individual modules for AND, OR, NOT gates using assign statements.

// Module for AND Gate
module and_gate (
    input wire a,    // Input 1
    input wire b,    // Input 2
    output wire y    // Output
);
    assign y = a & b; // AND operation
endmodule

// Module for OR Gate
module or_gate (
    input wire a,    // Input 1
    input wire b,    // Input 2
    output wire y    // Output
);
    assign y = a | b; // OR operation
endmodule

// Module for NOT Gate
module not_gate (
    input wire a,    // Input
    output wire y    // Output
);
    assign y = ~a; // NOT operation
endmodule

// Testbench to Simulate Logic Gates
module test_gates;
    reg a, b;        // Inputs for AND and OR gates
    wire and_out, or_out, not_out_a; // Outputs

    // Instantiate modules
    and_gate u1 (
        .a(a),
        .b(b),
        .y(and_out)
    );

    or_gate u2 (
        .a(a),
        .b(b),
        .y(or_out)
    );

    not_gate u3 (
        .a(a),
        .y(not_out_a)
    );

    // Test different input combinations
    initial begin
        // Monitor output values
        $monitor("Time=%0t | a=%b b=%b | AND=%b OR=%b NOT(a)=%b", $time, a, b, and_out, or_out, not_out_a);

        // Test case 1: a=0, b=0
        a = 0; b = 0;
        #10;

        // Test case 2: a=0, b=1
        a = 0; b = 1;
        #10;

        // Test case 3: a=1, b=0
        a = 1; b = 0;
        #10;

        // Test case 4: a=1, b=1
        a = 1; b = 1;
        #10;

        // End simulation
        $finish;
    end
endmodule
