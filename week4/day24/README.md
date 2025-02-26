# Day 24: Implement Constrained Random Testing

## Overview
**Constrained Random Testing (CRT)** in SystemVerilog allows automatic generation of test inputs while applying constraints to ensure meaningful values. This approach increases coverage and helps catch unexpected design errors. In this session, we will modify the **ALU testbench** to apply random inputs and use constraints to limit the range of values.

---

## 1. Understanding Randomization in SystemVerilog
### 1.1 Purpose of Constrained Random Testing
- **Automates test generation**, reducing manual effort.
- **Increases coverage** by testing more input combinations.
- **Prevents illegal values** by applying constraints.

### 1.2 Using `$random` and `std::randomize`
SystemVerilog provides multiple methods for randomization:
- **`$random`**: Generates random values without constraints.
- **`std::randomize`**: Supports **constraint-driven** randomization.

---

## 2. Modifying the ALU Testbench for Random Inputs
### 2.1 Updated ALU Testbench with Randomization
We modify the testbench to randomly generate values for `a`, `b`, and `op`, ensuring valid operations.

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
    
    // Apply random test vectors with constraints
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        repeat (10) begin
            assert(std::randomize(a, b, op) with {
                a inside {[0:15]};
                b inside {[0:15]};
                op inside {[0:4]}; // Ensure only valid ALU operations
            }) else $error("Randomization failed");
            
            #10;
            assert (op == 3'b000 -> result == a + b) else $error("Addition failed");
            assert (op == 3'b001 -> result == a - b) else $error("Subtraction failed");
            assert (op == 3'b010 -> result == (a & b)) else $error("AND operation failed");
            assert (op == 3'b011 -> result == (a | b)) else $error("OR operation failed");
            assert (op == 3'b100 -> result == (a ^ b)) else $error("XOR operation failed");
        end
        
        $stop;
    end
endmodule
```

---

## 3. Running the Testbench with Random Inputs
### 3.1 Observing Randomized Tests
1. **Compile and run the testbench** in a SystemVerilog simulator.
2. Observe different random values applied during each iteration.
3. Ensure assertions validate expected ALU outputs.

### 3.2 Sample Output (Randomized Execution)
```
Time=0  | A=1010 | B=1101 | OP=010 | RESULT=1000
Time=10 | A=0011 | B=0111 | OP=000 | RESULT=1010
Time=20 | A=0101 | B=0001 | OP=001 | RESULT=0100
Time=30 | A=1111 | B=0000 | OP=011 | RESULT=1111
Time=40 | A=1100 | B=1001 | OP=100 | RESULT=0101
```

### 3.3 Handling Randomization Failures
If `std::randomize` fails, the testbench will print an error, ensuring invalid test cases do not proceed.

---

## 4. Key Takeaways
- **Randomization** helps improve verification coverage.
- **Constraints** ensure generated values remain within valid ranges.
- **Assertions** validate correctness dynamically for multiple random inputs.

### 🚀 Next Steps
- Experiment with **larger bit-width values** for ALU inputs.
- Extend the testbench to log unexpected values for debugging.

---

This concludes **Day 24: Implement Constrained Random Testing** in SystemVerilog. Keep testing smarter! 🚀

