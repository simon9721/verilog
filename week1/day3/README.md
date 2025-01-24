# Day 3: Implement Basic Logic Gates

## Objective
Learn how to create Verilog modules for basic logic gates (AND, OR, NOT) and simulate them using a testbench to verify functionality.

---

## 1. Logic Gates Overview
Logic gates are the fundamental building blocks of digital circuits. Each gate performs a specific logical operation on one or more input signals to produce an output signal.

### Gates to Implement:
1. **AND Gate**: Outputs `1` only if both inputs are `1`.
2. **OR Gate**: Outputs `1` if at least one input is `1`.
3. **NOT Gate**: Inverts the input signal.

---

## 2. Writing Verilog Modules
Each logic gate is implemented as a separate Verilog module. We use the `assign` statement to describe the behavior of each gate.

### AND Gate:
```verilog
module and_gate (
    input wire a,    // Input 1
    input wire b,    // Input 2
    output wire y    // Output
);
    assign y = a & b; // AND operation
endmodule
```

### OR Gate:
```verilog
module or_gate (
    input wire a,    // Input 1
    input wire b,    // Input 2
    output wire y    // Output
);
    assign y = a | b; // OR operation
endmodule
```

### NOT Gate:
```verilog
module not_gate (
    input wire a,    // Input
    output wire y    // Output
);
    assign y = ~a; // NOT operation
endmodule
```

---

## 3. Simulating the Logic Gates
To verify the functionality of the gates, a testbench is created. The testbench applies various input combinations and observes the outputs.

### Testbench Code:
```verilog
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
```

---

## 4. Steps to Simulate
1. Save the code for the modules and the testbench in separate `.v` files (e.g., `and_gate.v`, `or_gate.v`, `not_gate.v`, `test_gates.v`).
2. Compile the files using a Verilog simulator (e.g., ModelSim, Vivado).
3. Run the simulation.
4. Observe the outputs in the simulation console to verify correct behavior.

### Expected Output:
For each input combination, the console should display:
```
Time=0 | a=0 b=0 | AND=0 OR=0 NOT(a)=1
Time=10 | a=0 b=1 | AND=0 OR=1 NOT(a)=1
Time=20 | a=1 b=0 | AND=0 OR=1 NOT(a)=0
Time=30 | a=1 b=1 | AND=1 OR=1 NOT(a)=0
```

---

## 5. Activity
### Task:
1. Write individual Verilog modules for **AND**, **OR**, and **NOT** gates.
2. Create a testbench to verify the behavior of each gate.
3. Simulate the modules using different input combinations.

### Challenge:
Extend the testbench to include another gate, such as a **NAND** gate, and test its functionality.

---

## 6. Reflection
- How does the `assign` statement simplify combinational logic?
- What did you observe about the relationship between the inputs and outputs for each gate?