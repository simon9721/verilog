# Day 9: Implement a JK Flip-Flop

## Understanding the JK Flip-Flop
A **JK flip-flop** is a type of bistable multivibrator, an extension of the SR flip-flop, where the **J (Set)** and **K (Reset)** inputs eliminate the invalid state present in SR flip-flops. It has the following properties:

- **J = 1, K = 0** → Set the output to 1
- **J = 0, K = 1** → Reset the output to 0
- **J = 0, K = 0** → Hold the previous state
- **J = 1, K = 1** → Toggle the output

This makes it a versatile storage element commonly used in sequential circuits.

---

## JK Flip-Flop Module
### Verilog Code
```verilog
module jk_flip_flop (
    input wire clk,
    input wire rst,
    input wire J,
    input wire K,
    output reg Q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 0;
    else begin
        case ({J, K})
            2'b00: Q <= Q;   // Hold State
            2'b01: Q <= 0;   // Reset
            2'b10: Q <= 1;   // Set
            2'b11: Q <= ~Q;  // Toggle
        endcase
    end
end

endmodule
```

---

## Testbench for Simulation
To verify the correctness of the JK flip-flop, we simulate it with different inputs and observe its behavior.

### Verilog Testbench
```verilog
`timescale 1ns / 1ps

module jk_flip_flop_tb;
    reg clk, rst, J, K;
    wire Q;
    
    jk_flip_flop uut (
        .clk(clk),
        .rst(rst),
        .J(J),
        .K(K),
        .Q(Q)
    );
    
    always #5 clk = ~clk; // Generate clock signal
    
    initial begin
        $dumpfile("jk_flip_flop_tb.vcd");
        $dumpvars(0, jk_flip_flop_tb);
        
        clk = 0; rst = 1; J = 0; K = 0;
        #10 rst = 0; // Deassert reset
        
        #10 J = 0; K = 0; // Hold State
        #10 J = 0; K = 1; // Reset
        #10 J = 1; K = 0; // Set
        #10 J = 1; K = 1; // Toggle
        #10 J = 0; K = 0; // Hold State
        #10 $finish;
    end
    
endmodule
```

---

## Expected Simulation Results
After running the testbench, the waveform should match the characteristic table of the JK flip-flop:

| J | K | Q (Next State) |
|---|---|---------------|
| 0 | 0 | Q (Hold) |
| 0 | 1 | 0 (Reset) |
| 1 | 0 | 1 (Set) |
| 1 | 1 | ~Q (Toggle) |

---

## Activity
1. **Write the JK Flip-Flop Module**: Implement the Verilog code as shown above.
2. **Simulate the Testbench**: Run the testbench and analyze the waveform.
3. **Compare with the Characteristic Table**: Ensure that the output matches expectations.

This exercise reinforces the understanding of sequential logic and state transitions in flip-flops.

---

### 🎯 Learning Outcome:
- Understand how a JK flip-flop works.
- Implement and simulate a JK flip-flop in Verilog.
- Analyze the characteristic table through waveform results.


