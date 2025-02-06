# Day 8: Introduction to Flip-Flops

## What is a Flip-Flop?
A **flip-flop** is a sequential circuit element that stores one bit of information and changes state based on a clock signal. Unlike combinational logic, flip-flops depend on past inputs, making them essential for memory elements and state machines in digital circuits.

### The D Flip-Flop
The **D flip-flop** (Data or Delay flip-flop) is one of the simplest and most commonly used flip-flops. It ensures that the output follows the input at the moment of the clock edge, making it useful for data storage and synchronization.

#### Characteristics:
- **Input (D):** The data input that gets stored in the flip-flop.
- **Clock (clk):** A triggering signal that determines when the output changes.
- **Output (Q):** Stores the last value of D at the active clock edge.
- **Reset (rst):** An asynchronous or synchronous signal to reset Q to 0.

### Verilog Implementation of a D Flip-Flop
We implement the D flip-flop using **procedural blocks** (i.e., `always` blocks). Below is a Verilog module for a D flip-flop with an asynchronous reset.

```verilog
module d_flip_flop (
    input wire clk,      // Clock signal
    input wire rst,      // Asynchronous reset
    input wire d,        // Data input
    output reg q        // Output Q
);
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0; // Reset Q to 0
        else
            q <= d; // Capture input D at rising clock edge
    end
    
endmodule
```

### Explanation of the Code:
- The `always` block is triggered on the **positive edge** of `clk` or `rst`.
- If `rst` is high, `q` is set to 0 immediately.
- Otherwise, on the rising edge of `clk`, `q` is assigned the value of `d`.

## Simulating the D Flip-Flop
To verify our design, we need a **testbench**. The following testbench generates a clock signal and toggles the input `d` while observing `q`.

```verilog
`timescale 1ns / 1ps
module tb_d_flip_flop();
    
    reg clk;
    reg rst;
    reg d;
    wire q;
    
    // Instantiate the D flip-flop
    d_flip_flop uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns period (100MHz clock)
    
    initial begin
        // Initialize signals
        clk = 0; rst = 1; d = 0;
        #10 rst = 0; // Release reset
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 1;
        #10 d = 0;
        #10 $stop;
    end
    
endmodule
```

### Simulation Overview:
- The clock toggles every 5 ns (100 MHz frequency).
- Initially, `rst` is asserted to reset `q`.
- After reset is deactivated, `d` changes at regular intervals.
- The output `q` should follow `d` at each rising clock edge.

### Expected Output:
- Initially, `q = 0` due to reset.
- After reset is released, `q` updates to match `d` on each rising clock edge.

## Task
1. Implement the `d_flip_flop` module in Verilog.
2. Write a testbench to simulate the behavior with a clock and test data.
3. Run the simulation and observe how `q` follows `d` at the clock edges.
4. Share your waveform results!

This exercise reinforces the fundamental concept of sequential logic and prepares you for designing more complex state machines.

---
Happy coding! 🚀

