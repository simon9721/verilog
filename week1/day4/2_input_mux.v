// Day 4: Create a 2-to-1 Multiplexer
// Task: Design a 2:1 MUX using the conditional (? :) operator.

// Module definition for the 2:1 Multiplexer
module mux_2to1 (
    input wire a,        // Input 1
    input wire b,        // Input 2
    input wire sel,      // Select line
    output wire y        // Output
);
    // Using the conditional operator to assign the output
    assign y = (sel) ? b : a;
endmodule

// Testbench for the 2:1 Multiplexer
module testbench;
    reg a;        // Declare inputs as registers for testing
    reg b;
    reg sel;
    wire y;       // Declare output as wire

    // Instantiate the MUX module
    mux_2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    // Test procedure
    initial begin
        $monitor("a=%b, b=%b, sel=%b, y=%b", a, b, sel, y); // Monitor the changes

        // Test case 1: sel = 0, output should follow input a
        a = 0; b = 0; sel = 0; #10;
        a = 1; b = 0; sel = 0; #10;

        // Test case 2: sel = 1, output should follow input b
        a = 0; b = 1; sel = 1; #10;
        a = 1; b = 1; sel = 1; #10;

        // Additional edge cases
        a = 0; b = 1; sel = 0; #10;
        a = 1; b = 0; sel = 1; #10;

        // End the simulation
        $finish;
    end
endmodule
