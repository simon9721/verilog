# Day 21: Explore SystemVerilog Enhancements

## Overview
SystemVerilog introduces several enhancements over traditional Verilog, improving code clarity, efficiency, and safety. Key enhancements include the **logic** data type and **enhanced always blocks**. In this session, we will update previous modules to use SystemVerilog syntax and analyze the benefits.

---

## 1. SystemVerilog Enhancements
### 1.1 Logic Data Type
- **`logic`** replaces `reg` and `wire`, offering more robust simulation behavior.
- Unlike `reg`, `logic` prevents unintended multiple drivers, reducing simulation errors.

#### Example Conversion:
**Verilog:**
```verilog
reg [3:0] data;
```
**SystemVerilog:**
```systemverilog
logic [3:0] data;
```

### 1.2 Enhanced Always Blocks
- SystemVerilog introduces **`always_comb`**, **`always_ff`**, and **`always_latch`**.
- These constructs improve clarity by explicitly defining behavior.

#### Example Conversion:
**Verilog:**
```verilog
always @(a or b) begin
    y = a & b;
end
```
**SystemVerilog:**
```systemverilog
always_comb begin
    y = a & b;
end
```

---

## 2. Updating Previous Modules
### 2.1 Updating the ALU Module
We update the **ALU module** to use `logic` and `always_comb`:
```systemverilog
module alu (
    input logic [3:0] a, b,
    input logic [2:0] op,
    output logic [3:0] result
);
    always_comb begin
        case (op)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            default: result = 4'b0000;
        endcase
    end
endmodule
```

### 2.2 Updating the FIFO Buffer Module
We update the **FIFO buffer** with `logic` and `always_ff` for sequential behavior:
```systemverilog
module fifo_buffer (
    input logic clk, rst,
    input logic wr_en, rd_en,
    input logic [7:0] din,
    output logic [7:0] dout,
    output logic full, empty
);
    logic [7:0] fifo_memory [0:15];
    logic [3:0] write_ptr, read_ptr;
    logic [4:0] count;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            if (wr_en && !full) begin
                fifo_memory[write_ptr] <= din;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                dout <= fifo_memory[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
            end
            full <= (count == 16);
            empty <= (count == 0);
        end
    end
endmodule
```

---

## 3. Key Differences and Benefits
| Feature | Verilog | SystemVerilog | Benefits |
|---------|--------|--------------|----------|
| **Data Type** | `reg` and `wire` | `logic` | Prevents multiple drivers, improves debugging |
| **Always Block** | `always @(*)` | `always_comb` | Ensures purely combinational logic |
| **Sequential Logic** | `always @(posedge clk)` | `always_ff` | Clearly defines sequential behavior |
| **Array Indexing** | Traditional | Packed & Unpacked | Easier memory modeling |

### 🚀 Next Steps
Continue refining previous modules with SystemVerilog syntax, and explore other enhancements like **interfaces, structures, and assertions**!

---

This concludes **Day 21: Explore SystemVerilog Enhancements**. Keep improving your code! 🚀

