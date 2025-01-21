// Day 2: Data Types and Operators

// Module to demonstrate Verilog data types (wire, reg) and basic operators
module DataTypesAndOperators;

    // **Detailed Explanation of Data Types**
    // `wire`:
    // - Represents a physical wire connection.
    // - Used for continuous assignments and driven by outputs of other modules or gates.
    // - Cannot store values; they reflect the signal assigned to them in real-time.
    // - Syntax: wire [width] variable_name;

    // `reg`:
    // - Represents a storage element that holds its value until explicitly changed.
    // - Typically used in procedural blocks (e.g., `initial` and `always` blocks).
    // - Syntax: reg [width] variable_name;

    // Declare wires and registers
    wire [3:0] wire_a;         // 4-bit wire
    wire [3:0] wire_b;
    reg [3:0] reg_a;           // 4-bit register
    reg [3:0] reg_b;

    // Declare other registers for output
    reg [3:0] sum;
    reg [3:0] and_result;
    reg [3:0] or_result;
    reg [3:0] not_result;
    reg [3:0] shift_left_result;
    reg [3:0] shift_right_result;

    // **Operators in Verilog**
    // - Arithmetic Operators: +, -, *, /, %
    // - Logical Operators: &, |, ~, ^ (AND, OR, NOT, XOR)
    // - Relational Operators: ==, !=, <, <=, >, >=
    // - Shift Operators: << (logical left), >> (logical right)
    // - Concatenation Operator: { }
    // - Reduction Operators: & (AND reduction), | (OR reduction), etc.

    // Initialize reg values in an initial block
    initial begin
        // Assign values to registers
        reg_a = 4'b1010;        // Binary value (10 in decimal)
        reg_b = 4'b0101;        // Binary value (5 in decimal)

        // **Arithmetic Operations**
        sum = reg_a + reg_b;    // Addition

        // **Logical Operations**
        and_result = reg_a & reg_b; // Bitwise AND operation
        or_result = reg_a | reg_b;  // Bitwise OR operation
        not_result = ~reg_a;        // Bitwise NOT operation

        // **Shift Operations**
        shift_left_result = reg_a << 1;  // Logical left shift by 1
        shift_right_result = reg_a >> 1; // Logical right shift by 1

        // **Display the Results**
        $display("Register A: %b", reg_a);
        $display("Register B: %b", reg_b);
        $display("Sum (A + B): %b", sum);
        $display("AND Result (A & B): %b", and_result);
        $display("OR Result (A | B): %b", or_result);
        $display("NOT Result (~A): %b", not_result);
        $display("Shift Left Result (A << 1): %b", shift_left_result);
        $display("Shift Right Result (A >> 1): %b", shift_right_result);
    end

    // **Continuous Assignment with Wires**
    // Assign values to wires using continuous assignment
    assign wire_a = reg_a;       // Wire reflects the value of reg_a
    assign wire_b = reg_b;       // Wire reflects the value of reg_b

endmodule
