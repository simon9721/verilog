# Day 20: Design an Arithmetic Logic Unit (ALU)

## Overview
An **Arithmetic Logic Unit (ALU)** is a critical component of digital processors. It performs basic arithmetic and logic operations. In this session, we will design a **4-bit ALU** that supports addition, subtraction, AND, OR, and XOR operations.

---

## 1. Understanding ALU Operations
### 1.1 Supported ALU Functions
- **Addition (`+`)**: Computes the sum of two inputs.
- **Subtraction (`-`)**: Computes the difference between two inputs.
- **Bitwise AND (`&`)**: Performs a logical AND operation.
- **Bitwise OR (`|`)**: Performs a logical OR operation.
- **Bitwise XOR (`^`)**: Performs a logical XOR operation.

### 1.2 ALU Control Signals
An **operation select input** determines which function the ALU performs:
```verilog
parameter ADD = 3'b000, SUB = 3'b001, AND_OP = 3'b010, OR_OP = 3'b011, XOR_OP = 3'b100;
```
---

## 2. Implementing the ALU
### 2.1 ALU Module Design
Below is a Verilog implementation of a **4-bit ALU**:

```verilog
module alu (
    input wire [3:0] a, b,        // 4-bit inputs
    input wire [2:0] op,          // Operation select
    output reg [3:0] result       // 4-bit output
);
    
    always @(*) begin
        case (op)
            3'b000: result = a + b;   // Addition
            3'b001: result = a - b;   // Subtraction
            3'b010: result = a & b;   // Bitwise AND
            3'b011: result = a | b;   // Bitwise OR
            3'b100: result = a ^ b;   // Bitwise XOR
            default: result = 4'b0000; // Default case
        endcase
    end
endmodule
```

---

## 3. Simulating ALU Operations
### 3.1 Testbench for ALU
To test the ALU module, we will verify each operation by applying different inputs and checking the results.

```verilog
module alu_tb;
    reg [3:0] a, b;
    reg [2:0] op;
    wire [3:0] result;
    
    // Instantiate the ALU module
    alu uut (
        .a(a), .b(b), .op(op), .result(result)
    );
    
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        // Test Addition
        a = 4'b0011; b = 4'b0001; op = 3'b000; #10;
        
        // Test Subtraction
        a = 4'b0100; b = 4'b0001; op = 3'b001; #10;
        
        // Test AND
        a = 4'b1100; b = 4'b1010; op = 3'b010; #10;
        
        // Test OR
        a = 4'b1100; b = 4'b1010; op = 3'b011; #10;
        
        // Test XOR
        a = 4'b1100; b = 4'b1010; op = 3'b100; #10;
        
        $stop;
    end
endmodule
```

---

## 4. Key Takeaways
- **ALUs** perform arithmetic and logical operations based on an operation select input.
- **Verilog case statements** allow efficient operation selection.
- **Testbenches** verify ALU correctness by applying different inputs and checking outputs.

### 🚀 Next Steps
Extend the ALU by adding more operations, such as **negation, left shift, and right shift**!

---

This concludes **Day 20: Design an Arithmetic Logic Unit (ALU)** in Verilog. Keep coding! 🎯

