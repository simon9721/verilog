# Day 22: Introduction to Testbenches

## Overview
A **testbench** is a crucial component in verifying digital designs. It provides a controlled environment to apply inputs to a design module and observe its behavior. In this session, we will learn how to write a basic testbench in **Verilog/SystemVerilog** and apply test vectors to the **ALU module**.

---

## 1. Understanding Testbenches
### 1.1 What is a Testbench?
A testbench is a non-synthesizable Verilog/SystemVerilog module that:
- Instantiates the **design under test (DUT)**.
- Provides **input stimuli** using `initial` blocks.
- Observes and displays **output results** using `$monitor` or `$display`.

### 1.2 Basic Testbench Structure
A typical testbench includes:
1. **Module declaration (no ports required)**.
2. **Registers for input signals** and **wires for outputs**.
3. **Instantiation of the DUT**.
4. **Initial block** to apply test vectors.
5. **Monitoring statements** to observe outputs.

---

## 2. Writing a Testbench for the ALU Module
### 2.1 ALU Testbench Code
Below is a testbench to verify the **ALU module**:

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
    
    // Apply test vectors
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

## 3. Running the Testbench
### 3.1 Simulating the Testbench
To run the testbench:
1. Compile the design and testbench using a **Verilog simulator** (e.g., ModelSim, VCS, Icarus Verilog).
2. Observe the output waveform or terminal results.
3. Ensure the ALU produces correct results for each operation.

### 3.2 Expected Output (Console Log)
```
Time=0  | A=0011 | B=0001 | OP=000 | RESULT=0100
Time=10 | A=0100 | B=0001 | OP=001 | RESULT=0011
Time=20 | A=1100 | B=1010 | OP=010 | RESULT=1000
Time=30 | A=1100 | B=1010 | OP=011 | RESULT=1110
Time=40 | A=1100 | B=1010 | OP=100 | RESULT=0110
```

---

## 4. Key Takeaways
- **Testbenches** are essential for verifying module functionality.
- **Initial blocks** apply test stimuli and observe outputs.
- **Simulation** helps validate circuit behavior before hardware implementation.

### 🚀 Next Steps
Modify the testbench to:
- Add more test cases.
- Use `for` loops to automate testing.
- Display results in a waveform viewer.

---

This concludes **Day 22: Introduction to Testbenches** in Verilog/SystemVerilog. Keep testing! 🚀

