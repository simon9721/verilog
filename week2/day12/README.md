# Day 12: Modify the Counter to Count Down

## Objective
Today, we will modify an existing up-counter to function as a down-counter. Additionally, we will introduce a control input that allows switching between up and down counting modes.

---

## 1. Understanding the Modification
A basic counter increments a value on each clock cycle. To modify it into a down-counter:
- We need to introduce a **direction control input** (`dir`), which determines whether the counter counts up or down.
- When `dir = 1`, the counter should count up.
- When `dir = 0`, the counter should count down.
- The design should ensure that the counter does not overflow or underflow unexpectedly.

---

## 2. Implementing the Direction Control Input
### Updated Verilog Code
```verilog
module up_down_counter (
    input wire clk,
    input wire rst,
    input wire dir,      // Direction control: 1 = up, 0 = down
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'b0000;  // Reset counter to 0
    else if (dir)
        count <= count + 1;  // Count up
    else
        count <= count - 1;  // Count down
end

endmodule
```

### Explanation:
- The `dir` input controls whether the counter increments or decrements.
- The counter is 4-bit wide (`count[3:0]`), meaning it can count from `0000` (0) to `1111` (15).
- The `always` block triggers on the **rising edge of `clk`** or when `rst` is asserted.
- If `rst` is high, the counter resets to 0.
- If `dir = 1`, the counter increases.
- If `dir = 0`, the counter decreases.

---

## 3. Simulating the Counter
To verify the design, create a testbench that:
1. Initializes the counter.
2. Runs it in **up-counting mode** for a few cycles.
3. Switches to **down-counting mode** and observes the behavior.

### Testbench
```verilog
module tb_up_down_counter;

reg clk, rst, dir;
wire [3:0] count;

// Instantiate the counter module
up_down_counter uut (
    .clk(clk),
    .rst(rst),
    .dir(dir),
    .count(count)
);

// Clock Generation
always #5 clk = ~clk; // 10ns clock period

initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    dir = 1;
    #10 rst = 0;  // Deassert reset

    // Count up for 5 cycles
    #50 dir = 0;  // Switch to count down

    // Count down for 5 cycles
    #50 $stop;  // End simulation
end

endmodule
```

### Expected Simulation Output:
```
Time   dir  count
-----------------
 0ns    1    0000 (reset state)
10ns    1    0001
20ns    1    0010
30ns    1    0011
40ns    1    0100
50ns    0    0011 (direction changed)
60ns    0    0010
70ns    0    0001
80ns    0    0000
90ns    0    1111 (wrap-around behavior if unsigned)
```

---

## 4. Additional Enhancements
- **Preventing Underflow/Overflow:** The counter can be modified to stop at `0000` when counting down or `1111` when counting up, preventing wrap-around.
- **Adding Load and Enable Signals:** Implement additional control inputs to preload a value or enable/disable counting.
- **Expanding Bit Width:** Modify the counter to have a larger range, e.g., an 8-bit counter (`[7:0] count`).

---

## 5. Your Task
- Implement the counter in a Verilog simulator.
- Modify it to prevent wrap-around.
- Explore different bit-widths and observe their impact.
- Share your results and observations!

Happy coding! 🚀

