# Day 17: Introduction to Memory Modules in Verilog

## Overview
Memory modules are essential components in digital systems, enabling storage and retrieval of data. Verilog provides methods to model both **RAM (Random Access Memory)** and **ROM (Read-Only Memory)** using arrays and file initialization techniques. In this lecture, we will explore array declaration and initialization, then implement a simple ROM module.

---

## 1. Understanding Memory in Verilog
### 1.1 RAM vs. ROM
- **RAM (Random Access Memory)**: Allows both read and write operations. Used for temporary data storage.
- **ROM (Read-Only Memory)**: Stores pre-defined data that cannot be modified during execution.

Verilog models memory using **register arrays**.

### 1.2 Declaring Memory Arrays
Memory in Verilog is typically declared using a **register array**:
```verilog
reg [7:0] memory_array [0:15];  // 16 words, each 8-bit wide
```
Here:
- `[7:0]` defines each memory location as 8-bit wide.
- `[0:15]` defines 16 locations (address range 0 to 15).

### 1.3 Initializing Memory Arrays
Memory can be initialized using two approaches:
1. **Explicit Initialization**
   ```verilog
   initial begin
       memory_array[0] = 8'h12;
       memory_array[1] = 8'h34;
       memory_array[2] = 8'h56;
       memory_array[3] = 8'h78;
   end
   ```
2. **Reading from an External File**
   ```verilog
   initial begin
       $readmemb("memory_file.dat", memory_array); // Binary values
       //$readmemh("memory_file.dat", memory_array); // Hex values
   end
   ```
   - `memory_file.dat` contains values loaded into `memory_array`.

---

## 2. Implementing a Simple ROM Module
### 2.1 Module Design
We will implement a small **ROM module** that stores predefined values and allows read access.

```verilog
module simple_rom (
    input wire [3:0] addr,  // 4-bit address (16 locations)
    output reg [7:0] data   // 8-bit output data
);
    // Declare ROM memory (16 locations, 8-bit each)
    reg [7:0] rom_memory [0:15];
    
    // Initialize ROM contents
    initial begin
        rom_memory[0]  = 8'hA1;
        rom_memory[1]  = 8'hB2;
        rom_memory[2]  = 8'hC3;
        rom_memory[3]  = 8'hD4;
        rom_memory[4]  = 8'hE5;
        rom_memory[5]  = 8'hF6;
        rom_memory[6]  = 8'h07;
        rom_memory[7]  = 8'h18;
        rom_memory[8]  = 8'h29;
        rom_memory[9]  = 8'h3A;
        rom_memory[10] = 8'h4B;
        rom_memory[11] = 8'h5C;
        rom_memory[12] = 8'h6D;
        rom_memory[13] = 8'h7E;
        rom_memory[14] = 8'h8F;
        rom_memory[15] = 8'h90;
    end
    
    // Read operation
    always @(*) begin
        data = rom_memory[addr];
    end
endmodule
```

### 2.2 Testbench for ROM
To verify the ROM functionality, we can write a simple testbench:

```verilog
module rom_tb;
    reg [3:0] address;
    wire [7:0] data_out;
    
    // Instantiate the ROM module
    simple_rom uut (
        .addr(address),
        .data(data_out)
    );
    
    initial begin
        $monitor("Time=%0t | Addr=%h | Data=%h", $time, address, data_out);
        
        address = 4'h0; #10;
        address = 4'h1; #10;
        address = 4'h2; #10;
        address = 4'h3; #10;
        address = 4'h4; #10;
        address = 4'h5; #10;
        address = 4'h6; #10;
        address = 4'h7; #10;
        address = 4'h8; #10;
        address = 4'h9; #10;
        address = 4'hA; #10;
        address = 4'hB; #10;
        address = 4'hC; #10;
        address = 4'hD; #10;
        address = 4'hE; #10;
        address = 4'hF; #10;
        
        $stop;
    end
endmodule
```

---

## 3. Key Takeaways
- **Memory arrays** in Verilog are declared using `reg`.
- **ROM** stores predefined data and allows read-only access.
- **Initialization methods** include explicit assignment and file-based loading.
- **Testbenches** verify ROM behavior by checking output data for given addresses.

### 🚀 Next Steps
Try modifying the ROM module to use `$readmemh()` for file-based initialization, and observe how it changes the design flexibility.

---

This concludes **Day 17: Introduction to Memory Modules** in Verilog. Happy coding! 🎯

