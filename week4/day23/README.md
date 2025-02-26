# Day 23: Use SystemVerilog Assertions (SVA)

## Overview
**SystemVerilog Assertions (SVA)** are used in verification to validate expected behavior in hardware designs. Assertions help catch errors early in the simulation by ensuring that outputs meet design specifications. In this session, we will add **assertions** to the **ALU testbench** to check output correctness.

---

## 1. Understanding Assertions
### 1.1 Purpose of Assertions
Assertions:
- Automatically verify expected behavior.
- Detect design bugs early.
- Improve debugging efficiency.

### 1.2 Types of Assertions
- **Immediate Assertions (`assert`)**: Checked at the time they are encountered.
- **Concurrent Assertions (`assert property`)**: Monitored throughout simulation.

---

## 2. Adding Assertions to the ALU Testbench
### 2.1 Updated ALU Testbench with Assertions
We enhance the ALU testbench by including **immediate assertions** to verify output correctness.

```systemverilog
module alu_tb;
    // Declare test signals
    logic [3:0] a, b;
    logic [2:0] op;
    logic [3:0] result;
    
    // Instantiate the ALU module
    alu uut (
        .a(a), .b(b), .op(op), .result(result)
    );
    
    // Apply test vectors and check outputs using assertions
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        // Test Addition
        a = 4'b0011; b = 4'b0001; op = 3'b000; #10;
        assert(result == a + b) else $error("Addition failed");
        
        // Test Subtraction
        a = 4'b0100; b = 4'b0001; op = 3'b001; #10;
        assert(result == a - b) else $error("Subtraction failed");
        
        // Test AND
        a = 4'b1100; b = 4'b1010; op = 3'b010; #10;
        assert(result == (a & b)) else $error("AND operation failed");
        
        // Test OR
        a = 4'b1100; b = 4'b1010; op = 3'b011; #10;
        assert(result == (a | b)) else $error("OR operation failed");
        
        // Test XOR
        a = 4'b1100; b = 4'b1010; op = 3'b100; #10;
        assert(result == (a ^ b)) else $error("XOR operation failed");
        
        $stop;
    end
endmodule
```

---

## 3. Running the Testbench with Assertions
### 3.1 Observing Assertion Checks
1. **Compile and run the testbench** in a SystemVerilog simulator.
2. If an assertion fails, an error message is displayed.
3. If all assertions pass, the ALU behaves as expected.

### 3.2 Sample Output (Assertions Passed)
```
Time=0  | A=0011 | B=0001 | OP=000 | RESULT=0100
Time=10 | A=0100 | B=0001 | OP=001 | RESULT=0011
Time=20 | A=1100 | B=1010 | OP=010 | RESULT=1000
Time=30 | A=1100 | B=1010 | OP=011 | RESULT=1110
Time=40 | A=1100 | B=1010 | OP=100 | RESULT=0110
```

### 3.3 Sample Output (Assertions Failed)
```
ERROR: Addition failed at time 10
ERROR: Subtraction failed at time 20
```

---

## 4. Key Takeaways
- **Assertions** help catch functional errors during simulation.
- **Immediate assertions (`assert`)** validate expected values within the testbench.
- **Simulation results** provide immediate feedback if an operation fails.

### 🚀 Next Steps
- Extend assertions to cover invalid input cases.
- Explore **concurrent assertions (`assert property`)** for more advanced verification.

---

This concludes **Day 23: Use SystemVerilog Assertions (SVA)**. Keep verifying! 🚀

