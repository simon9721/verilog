# Day 25: Functional Coverage Basics

## Overview
**Functional coverage** is a key concept in **coverage-driven verification** that ensures all required scenarios are tested. SystemVerilog provides **coverage groups and coverpoints** to track whether specific input conditions and operations have been exercised during simulation. In this session, we will add **functional coverage** to the ALU testbench and analyze the coverage report to identify untested scenarios.

---

## 1. Understanding Functional Coverage
### 1.1 What is Functional Coverage?
Functional coverage is used to:
- Measure **how well test cases exercise the design**.
- Identify **gaps in testing** where specific conditions are missing.
- Improve **verification efficiency** by focusing on untested areas.

### 1.2 Key SystemVerilog Functional Coverage Constructs
- **Covergroup**: Defines a set of conditions to monitor.
- **Coverpoint**: Specifies signals or expressions to track.
- **Cross Coverage**: Captures interactions between multiple coverpoints.

---

## 2. Adding Coverage to the ALU Testbench
### 2.1 Updated ALU Testbench with Coverage
We enhance the testbench by adding **covergroups** to track input values and operations.

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
    
    // Define functional coverage
    covergroup alu_coverage;
        coverpoint a {
            bins all_values[] = {[0:15]}; // Track all possible input values
        }
        coverpoint b {
            bins all_values[] = {[0:15]};
        }
        coverpoint op {
            bins valid_ops[] = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100}; // Only valid operations
        }
        cross a, b, op; // Capture interactions between inputs and operations
    endgroup
    
    alu_coverage cg = new();
    
    // Apply test vectors and collect coverage data
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        repeat (50) begin
            assert(std::randomize(a, b, op) with {
                a inside {[0:15]};
                b inside {[0:15]};
                op inside {[0:4]};
            }) else $error("Randomization failed");
            
            cg.sample(); // Capture coverage data
            #10;
        end
        
        $stop;
    end
endmodule
```

---

## 3. Running the Testbench and Analyzing Coverage
### 3.1 Generating the Coverage Report
1. **Compile and run the testbench** in a SystemVerilog simulator with coverage enabled.
2. Generate the **functional coverage report**.
3. Identify bins with low or zero coverage, indicating untested scenarios.

### 3.2 Example Coverage Report
```
Coverage Report:
Covergroup alu_coverage
    a:  80% coverage
    b:  75% coverage
    op:  90% coverage
    a x b x op: 65% coverage (cross coverage)
```

### 3.3 Improving Coverage
- Increase the number of random tests.
- Adjust constraints to ensure all valid operations are exercised.
- Add **directed test cases** for rarely covered conditions.

---

## 4. Key Takeaways
- **Functional coverage** tracks test quality and completeness.
- **Covergroups and coverpoints** allow systematic monitoring of test scenarios.
- **Coverage reports** help identify untested conditions.

### 🚀 Next Steps
- Add **additional cross coverage** for detecting edge cases.
- Use **weighted randomization** to focus on rare scenarios.

---

This concludes **Day 25: Functional Coverage Basics** in SystemVerilog. Keep improving your verification strategy! 🚀

