# Day 5: Design a Half Adder

## Introduction
A **half adder** is a basic combinational circuit that performs the addition of two binary digits. It takes two single-bit binary inputs and produces a **sum** and a **carry** output. Understanding the half adder is fundamental to designing more complex arithmetic circuits like full adders and multipliers.

---

## 1. Half Adder Logic
A half adder consists of two logic gates:
1. **XOR Gate**: Computes the sum.
2. **AND Gate**: Computes the carry.

### Truth Table
| Input A | Input B | Sum (A ⊕ B) | Carry (A ⋅ B) |
|---------|---------|------------|--------------|
| 0       | 0       | 0          | 0            |
| 0       | 1       | 1          | 0            |
| 1       | 0       | 1          | 0            |
| 1       | 1       | 0          | 1            |

### Boolean Expressions
- **Sum** = A ⊕ B (XOR operation)
- **Carry** = A ⋅ B (AND operation)

---

## 2. Verilog Implementation
To implement the half adder in Verilog, we define a module `half_adder` with two inputs (`a` and `b`) and two outputs (`sum` and `carry`).

```verilog
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
```

### Explanation
1. **Module Declaration**: Defines `half_adder` with inputs `a` and `b`, and outputs `sum` and `carry`.
2. **Logic Implementation**:
   - `assign sum = a ^ b;` implements XOR operation.
   - `assign carry = a & b;` implements AND operation.

---

## 3. Testbench for Verification
To verify the functionality of our half adder, we create a testbench to simulate various input conditions.

```verilog
module half_adder_tb;

reg a, b;         // Test inputs
wire sum, carry;  // Outputs from the half adder

// Instantiate the half adder module
half_adder uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

initial begin
    // Test cases
    $monitor("a=%b, b=%b | sum=%b, carry=%b", a, b, sum, carry);
    
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    
    $finish;
end

endmodule
```

### Explanation
1. **Test Inputs**: `a` and `b` are defined as registers (`reg`).
2. **Output Wires**: `sum` and `carry` are defined as wires (`wire`).
3. **Instantiation**: The testbench instantiates the `half_adder` module.
4. **Simulation Process**:
   - `monitor` prints the values of `a`, `b`, `sum`, and `carry` in real-time.
   - Different test cases are applied with a 10-time-unit delay (`#10`).
   - `finish` terminates the simulation.

---

## 4. Running the Simulation
### Steps to Simulate
1. Compile the Verilog files using a simulator (ModelSim, Icarus Verilog, or Vivado).
2. Run the simulation and observe the output.
3. Verify that the outputs match the expected values from the truth table.

### Expected Output
```
a=0, b=0 | sum=0, carry=0
a=0, b=1 | sum=1, carry=0
a=1, b=0 | sum=1, carry=0
a=1, b=1 | sum=0, carry=1
```

---

## 5. Summary
- The half adder adds two binary bits and produces **sum** and **carry** outputs.
- Implemented using **XOR** (for sum) and **AND** (for carry) gates.
- We verified the design using a **testbench** and **simulation**.

### Next Steps
Now that you understand the half adder, try designing a **full adder**, which includes a carry-in input! 🚀
