# Day 4: Verilog - 2-to-1 Multiplexer

## Objective
Learn how to design a 2-to-1 Multiplexer (MUX) using the conditional operator (`? :`) in Verilog and verify its functionality through simulation.

---

## What is a Multiplexer?
A Multiplexer is a combinational circuit that selects one of the multiple input signals and forwards it to a single output line, based on the value of a select line.

### 2-to-1 Multiplexer
- **Inputs**: Two data inputs (`a` and `b`) and one select line (`sel`).
- **Output**: One output (`y`).
- **Function**: Based on the value of `sel`, the output is either:
  - `y = a` (if `sel = 0`)
  - `y = b` (if `sel = 1`)

---

## Verilog Implementation
### Module Code
Here’s how you can implement a 2-to-1 MUX using the conditional operator:

```verilog
module mux_2to1 (
    input wire a,        // Input 1
    input wire b,        // Input 2
    input wire sel,      // Select line
    output wire y        // Output
);
    // Using the conditional operator to assign the output
    assign y = (sel) ? b : a;
endmodule
```

### Explanation
1. **Inputs**:
   - `a` and `b` are the two data inputs.
   - `sel` is the select line.
2. **Conditional Operator**:
   - `y = (sel) ? b : a;` means:
     - If `sel` is 1, `y` is assigned the value of `b`.
     - If `sel` is 0, `y` is assigned the value of `a`.
3. **Output**:
   - `y` is the output of the MUX.

---

## Testing the 2-to-1 MUX
### Testbench Code
To verify the functionality of the MUX, create a testbench:

```verilog
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
```

### Explanation of the Testbench
1. **Module Instantiation**:
   - The MUX module is instantiated and connected to the testbench signals.
2. **Testing Cases**:
   - All combinations of inputs (`a`, `b`) and the select line (`sel`) are tested.
   - The `$monitor` statement logs the values of all inputs and the output in real time.
3. **Simulation Timing**:
   - `#10` introduces a delay of 10 time units between test cases.

---

## Activity
### Task
1. Write the 2-to-1 MUX module as described.
2. Implement the testbench and simulate the design.
3. Verify the output matches the expected results for all input and `sel` combinations.

### Expected Results
- When `sel = 0`, the output `y` should follow input `a`.
- When `sel = 1`, the output `y` should follow input `b`.

---

## Summary
In this session, we:
1. Designed a 2-to-1 Multiplexer using the conditional operator.
2. Created a testbench to verify its functionality.
3. Simulated and validated the MUX for all possible input conditions.

By mastering the 2-to-1 MUX, you’ve taken another step toward understanding combinational logic in Verilog. Keep practicing!
