# Day 11: Create a Simple Counter

## Task: Design a 4-bit Synchronous Up-Counter

### Introduction
A **counter** is a sequential circuit that progresses through a predefined sequence of states. Counters are commonly used in digital design for counting events, clock cycles, or generating specific sequences.

In this session, we will design a **4-bit synchronous up-counter**, simulate it, and observe its behavior.

---
## 1. Understanding Synchronous Counters
A **synchronous counter** is a type of counter where all flip-flops are triggered by the same clock signal. This eliminates issues like propagation delay that can be present in asynchronous counters.

### **Working Principle of an Up-Counter**
- The counter starts from `0000` and increments by `1` on each clock cycle.
- After reaching `1111`, it rolls over to `0000` (modulo-16 counting).
- A clock signal drives the entire counter, ensuring synchronized state transitions.

---
## 2. Writing the Verilog Code
The following Verilog module implements a **4-bit synchronous up-counter** using D flip-flops:

```verilog
module up_counter (
    input wire clk,       // Clock signal
    input wire reset,     // Active-high reset
    output reg [3:0] count // 4-bit count output
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000;  // Reset the counter to 0
        else
            count <= count + 1; // Increment count on clock edge
    end

endmodule
```

### **Explanation:**
1. `clk` is the input clock signal that drives the counter.
2. `reset` is an asynchronous reset that sets the count to `0000`.
3. `count` is the 4-bit output representing the counter value.
4. The `always` block executes on the **rising edge** of `clk` or `reset`.
5. When `reset` is active (`1`), the counter resets to `0000`.
6. Otherwise, the counter increments by `1` on each clock cycle.

---
## 3. Simulating the Counter
To verify the behavior of the counter, we write a **testbench**:

```verilog
module tb_up_counter;
    reg clk;
    reg reset;
    wire [3:0] count;

    up_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle every 5 time units

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0; // Deassert reset after 10 time units

        // Run simulation for 100 time units
        #100;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | Count=%b", $time, count);
    end
endmodule
```

### **Testbench Breakdown:**
- Generates a clock signal toggling every `5` time units.
- Asserts reset at the start (`reset = 1`), then deasserts it (`reset = 0`) after `10` time units.
- Runs the simulation for `100` time units.
- Uses `$monitor` to print the counter value at every simulation step.

---
## 4. Observing the Simulation Results
When simulated, the expected output sequence is:
```
Time=10 | Count=0000
Time=15 | Count=0001
Time=20 | Count=0010
Time=25 | Count=0011
...
Time=85 | Count=1110
Time=90 | Count=1111
Time=95 | Count=0000  // Rollover occurs here
```
### **Key Observations:**
- The counter increments by `1` on each rising edge of `clk`.
- Resets to `0000` when `reset` is active.
- Rolls over from `1111` to `0000` after 15 cycles.

---
## 5. Summary
- A **synchronous up-counter** ensures all state transitions occur simultaneously with the clock.
- The Verilog module implements a simple 4-bit counter using a register and an `always` block.
- The testbench verifies its functionality through simulation.
- Observing the count sequence confirms correct operation.

**Next Steps:** Try modifying the design to implement a **down-counter** or a **modulo-N counter**!

🚀 Happy coding!

