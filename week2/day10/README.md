# Day 10: Design a 4-bit Register

## Objective
Today, we will design a **4-bit parallel register** using **D flip-flops**. The register will have the ability to **load** data and **reset** to a default state. We will implement the design in Verilog and test it using a simulation.

---

## 1. Understanding a 4-bit Register
A **register** is a group of **flip-flops** that store multiple bits of data. In a **4-bit register**, each bit is stored using a **D flip-flop**. The register operates as follows:
- **Load Enable (`load`)**: When active, the register captures the input data.
- **Reset (`rst`)**: When active, all bits are set to 0.
- **Clock (`clk`)**: Controls the timing of data storage.

### Truth Table
| `rst` | `load` | `D[3:0]` | `Q[3:0]` (Next State) |
|-------|--------|----------|-----------------|
| 1     | X      | X        | 0000            |
| 0     | 1      | D3 D2 D1 D0 | D3 D2 D1 D0 |
| 0     | 0      | X        | Q3 Q2 Q1 Q0     |

---

## 2. Verilog Implementation
We will implement the **four_bit_register** module using **four D flip-flops**.

```verilog
module four_bit_register (
    input wire clk,         // Clock signal
    input wire rst,         // Reset signal
    input wire load,        // Load enable
    input wire [3:0] d,     // 4-bit input data
    output reg [3:0] q      // 4-bit stored output
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;  // Reset the register
        else if (load)
            q <= d;       // Load new data
    end
endmodule
```

---

## 3. Testbench for Simulation
To verify the register's behavior, we will create a testbench that:
1. Resets the register.
2. Loads different values.
3. Observes output behavior.

```verilog
module testbench;
    reg clk, rst, load;
    reg [3:0] d;
    wire [3:0] q;
    
    four_bit_register uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("four_bit_register.vcd");
        $dumpvars(0, testbench);
        
        // Initialize signals
        clk = 0; rst = 1; load = 0; d = 4'b0000;
        #10 rst = 0;
        
        // Load 1010 into the register
        #10 load = 1; d = 4'b1010;
        #10 load = 0;
        
        // Load 1100 into the register
        #10 load = 1; d = 4'b1100;
        #10 load = 0;
        
        // Reset
        #10 rst = 1;
        #10 rst = 0;
        
        #20 $finish;
    end
endmodule
```

---

## 4. Simulating the Register
### Steps:
1. Compile the Verilog code using **Icarus Verilog (iverilog)**:
   ```sh
   iverilog -o register_sim four_bit_register.v testbench.v
   ```
2. Run the simulation:
   ```sh
   vvp register_sim
   ```
3. View the waveform using GTKWave:
   ```sh
   gtkwave four_bit_register.vcd
   ```

---

## 5. Conclusion
In this session, you have successfully designed a **4-bit register** using **D flip-flops** and verified its functionality using a **testbench simulation**. This fundamental component is essential in designing **storage elements** within CPUs and digital systems.

---

### 🚀 Next Step
Try modifying the design to include an **enable signal** or experiment with **different flip-flop types**! Happy coding! 🎯

