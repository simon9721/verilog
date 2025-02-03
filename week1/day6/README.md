# Day 6: Build a Full Adder

## Introduction
In this lesson, we will expand upon the half adder to construct a **1-bit full adder**. Unlike a half adder, a full adder accounts for an additional carry-in bit, making it a fundamental building block for multi-bit addition in digital circuits.

---

## 1. Understanding the Full Adder
A **full adder** adds three 1-bit values:
- **Inputs**:
  - `A` (First input bit)
  - `B` (Second input bit)
  - `Cin` (Carry-in from the previous stage)
- **Outputs**:
  - `Sum` (Sum output bit)
  - `Cout` (Carry-out bit to the next stage)

### 1.1 Truth Table
| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 |  0  |  0  |  0   |
| 0 | 0 |  1  |  1  |  0   |
| 0 | 1 |  0  |  1  |  0   |
| 0 | 1 |  1  |  0  |  1   |
| 1 | 0 |  0  |  1  |  0   |
| 1 | 0 |  1  |  0  |  1   |
| 1 | 1 |  0  |  0  |  1   |
| 1 | 1 |  1  |  1  |  1   |

### 1.2 Boolean Equations
- **Sum** = (A ⊕ B) ⊕ Cin
- **Cout** = (A & B) | (Cin & (A ⊕ B))

---

## 2. Implementing the Full Adder Using Half Adders
A full adder can be built using **two half adders** and an **OR gate**:
- The first half adder computes the sum of `A` and `B`, producing an intermediate sum (`S1`) and a carry (`C1`).
- The second half adder computes the sum of `S1` and `Cin`, producing the final sum (`Sum`) and another carry (`C2`).
- An OR gate combines the two carry outputs (`C1` and `C2`) to produce the final carry-out (`Cout`).

### 2.1 Full Adder Circuit
```verilog
module half_adder(
    input wire a, b,
    output wire sum, carry
);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module full_adder(
    input wire A, B, Cin,
    output wire Sum, Cout
);
    wire S1, C1, C2;
    
    half_adder HA1 (.a(A), .b(B), .sum(S1), .carry(C1));
    half_adder HA2 (.a(S1), .b(Cin), .sum(Sum), .carry(C2));
    assign Cout = C1 | C2;
endmodule
```

---

## 3. Simulating the Full Adder
### 3.1 Testbench Code
To verify the full adder, simulate all possible input combinations using the following testbench:
```verilog
module full_adder_tb;
    reg A, B, Cin;
    wire Sum, Cout;
    
    full_adder FA (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));
    
    initial begin
        $monitor("A=%b, B=%b, Cin=%b | Sum=%b, Cout=%b", A, B, Cin, Sum, Cout);
        A = 0; B = 0; Cin = 0; #10;
        A = 0; B = 0; Cin = 1; #10;
        A = 0; B = 1; Cin = 0; #10;
        A = 0; B = 1; Cin = 1; #10;
        A = 1; B = 0; Cin = 0; #10;
        A = 1; B = 0; Cin = 1; #10;
        A = 1; B = 1; Cin = 0; #10;
        A = 1; B = 1; Cin = 1; #10;
        $stop;
    end
endmodule
```

---

## 4. Summary
### Key Takeaways
- A **full adder** extends a half adder by incorporating a carry-in (`Cin`).
- It can be constructed using **two half adders** and an **OR gate**.
- The circuit is verified using **simulation with all input combinations**.

---

## 5. Your Task
1. Implement the **full adder** using the Verilog code above.
2. Run the testbench and verify the correctness of your circuit.
3. Extend this design to build a **4-bit ripple carry adder** by chaining multiple full adders.

Happy coding! 🚀

