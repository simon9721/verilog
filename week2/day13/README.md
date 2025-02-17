# Day 13: Implement a Shift Register

## Overview
A **shift register** is a sequential logic circuit that shifts data bits through a series of flip-flops with each clock cycle. Shift registers are widely used in digital circuits for data storage, transfer, and conversion between serial and parallel data formats.

In this lesson, we will design and implement a **4-bit Serial In Parallel Out (SIPO) shift register** in Verilog.

---

## 1. Understanding the 4-bit SIPO Shift Register
A **Serial In Parallel Out (SIPO) shift register** takes in data **serially** (one bit per clock cycle) and outputs the accumulated data **in parallel** after 4 clock cycles.

### **Block Diagram:**
```
   Serial Input → [D Q] → [D Q] → [D Q] → [D Q] → Parallel Output
      (SI)       (Q0)    (Q1)    (Q2)    (Q3)
```

- **Serial Input (SI)**: The input data bit.
- **Clock (CLK)**: Controls the shifting process.
- **Parallel Outputs (Q3, Q2, Q1, Q0)**: Represents the 4-bit stored value.

---

## 2. Writing the Verilog Module
We will implement a shift register using **D flip-flops**.

### **Verilog Code: Shift Register (4-bit SIPO)**
```verilog
module shift_register (
    input wire clk,       // Clock signal
    input wire rst,       // Asynchronous reset
    input wire si,        // Serial input
    output reg [3:0] q    // Parallel output (4-bit)
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000; // Reset all outputs
        else
            q <= {q[2:0], si}; // Shift left and insert new bit
    end
endmodule
```

### **Explanation:**
- The **register `q`** stores the 4-bit parallel output.
- On a **clock rising edge**, the register shifts left, inserting the **new serial bit** (`si`) into the least significant bit (LSB).
- If the **reset (`rst`)** is activated, the register is cleared to `0000`.

---

## 3. Writing a Testbench
To verify the shift register, we will create a **testbench** that:
1. Applies a **clock signal**.
2. Sends a **serial data sequence**.
3. Observes the **parallel output**.

### **Verilog Testbench Code**
```verilog
module tb_shift_register;
    reg clk, rst, si;
    wire [3:0] q;
    
    // Instantiate the shift register
    shift_register uut (
        .clk(clk),
        .rst(rst),
        .si(si),
        .q(q)
    );
    
    // Clock generation (10ns period)
    always #5 clk = ~clk;
    
    initial begin
        // Initialize inputs
        clk = 0; rst = 1; si = 0;
        #10 rst = 0; // Release reset
        
        // Apply serial data: 1011
        #10 si = 1;
        #10 si = 0;
        #10 si = 1;
        #10 si = 1;
        
        // Observe parallel output
        #50 $stop;
    end
    
    initial begin
        $monitor("Time=%0t | SI=%b | Q=%b", $time, si, q);
    end
endmodule
```

### **Expected Simulation Output**
| Time (ns) | Serial Input | Parallel Output |
|-----------|-------------|----------------|
| 0         | 0           | 0000           |
| 10        | 1           | 0001           |
| 20        | 0           | 0010           |
| 30        | 1           | 0101           |
| 40        | 1           | 1011           |

---

## 4. Summary
- **We implemented a 4-bit SIPO shift register** using Verilog.
- **Data is shifted serially** into the register on each clock cycle.
- **The output becomes a 4-bit parallel representation** of the last four input bits.
- **A testbench verified the correct operation** through simulation.

---

## 5. Next Steps
- Modify the shift register to be **bidirectional (SISO & SIPO)**.
- Implement an **8-bit shift register**.
- Add an **enable signal** to control shifting.

#### 🚀 **Task:**
Try modifying the design to shift data in **both directions (left and right)** and observe the results!

