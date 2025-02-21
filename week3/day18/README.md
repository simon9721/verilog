# Day 18: Create a Simple RAM Module

## Overview
In this session, we will design a **single-port RAM module** with both **read** and **write** capabilities. Unlike ROM, RAM allows modifications to stored data during runtime, making it a fundamental component in digital systems.

---

## 1. Understanding RAM in Verilog
### 1.1 Single-Port RAM
A **single-port RAM** allows:
- **Write operation**: Data is written to the memory when the write enable (`we`) signal is high.
- **Read operation**: Data is read from the memory when the write enable (`we`) signal is low.

### 1.2 Declaring RAM Memory
```verilog
reg [7:0] ram_memory [0:15];  // 16 locations, each 8-bit wide
```

Each memory location can be accessed using an **address**.

---

## 2. Implementing a Simple RAM Module
### 2.1 Module Design
Below is a Verilog implementation of a simple **single-port RAM**:

```verilog
module simple_ram (
    input wire clk,             // Clock signal
    input wire we,              // Write enable (1 = write, 0 = read)
    input wire [3:0] addr,      // 4-bit address (16 locations)
    input wire [7:0] din,       // 8-bit input data
    output reg [7:0] dout       // 8-bit output data
);
    // Declare RAM memory (16 locations, 8-bit each)
    reg [7:0] ram_memory [0:15];
    
    always @(posedge clk) begin
        if (we) 
            ram_memory[addr] <= din;  // Write operation
        else 
            dout <= ram_memory[addr]; // Read operation
    end
endmodule
```

---

## 3. Simulating Read and Write Operations
### 3.1 Testbench for RAM
To test the RAM module, we will:
1. Write data to different addresses.
2. Read data back from those addresses.

```verilog
module ram_tb;
    reg clk;
    reg we;
    reg [3:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    // Instantiate the RAM module
    simple_ram uut (
        .clk(clk),
        .we(we),
        .addr(address),
        .din(data_in),
        .dout(data_out)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0;
        
        // Write operations
        we = 1; address = 4'h0; data_in = 8'hAA; #10;
        we = 1; address = 4'h1; data_in = 8'hBB; #10;
        we = 1; address = 4'h2; data_in = 8'hCC; #10;
        
        // Read operations
        we = 0; address = 4'h0; #10;
        we = 0; address = 4'h1; #10;
        we = 0; address = 4'h2; #10;
        
        $stop;
    end
endmodule
```

---

## 4. Key Takeaways
- **Single-port RAM** allows read/write operations based on the `we` signal.
- **Clock edge-triggered behavior** ensures synchronous updates.
- **Testbenches** validate RAM functionality by verifying stored data at different addresses.

### 🚀 Next Steps
Try modifying the RAM size or implementing a dual-port RAM to allow simultaneous read and write operations!

---

This concludes **Day 18: Create a Simple RAM Module** in Verilog. Keep coding! 🎯

