# Day 29: Implementing a FIFO Buffer for UART

## Overview
In this session, we will enhance our UART system by adding **FIFO (First-In-First-Out) buffers** to manage data flow efficiently. FIFOs help in handling temporary storage of transmitted and received data, ensuring smooth operation even when the CPU or other peripherals are busy.

---

## 1. Understanding FIFO in UART
### 1.1 Why Use a FIFO Buffer?
- **Smooth Data Handling**: Prevents data loss by storing received data until it's processed.
- **Decouples Data Transmission and Reception**: The TX module can continue sending data while the RX module processes previously received data.
- **Avoids Overruns and Underruns**: Prevents buffer overflow and ensures continuous data flow.

### 1.2 FIFO Buffer Operations
A FIFO buffer works with:
- **Write (Enqueue)**: Stores incoming data.
- **Read (Dequeue)**: Fetches stored data for processing.

---

## 2. Implementing the FIFO Buffer
### 2.1 UART FIFO Module
Below is a SystemVerilog implementation of a **FIFO buffer** for UART:

```systemverilog
module uart_fifo #(parameter DEPTH = 16) (
    input logic clk, rst, wr_en, rd_en,
    input logic [7:0] data_in,
    output logic [7:0] data_out,
    output logic full, empty
);
    logic [7:0] fifo_mem [0:DEPTH-1];
    logic [3:0] read_ptr, write_ptr, count;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            read_ptr <= 0;
            write_ptr <= 0;
            count <= 0;
        end else begin
            if (wr_en && !full) begin
                fifo_mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                data_out <= fifo_mem[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
            end
        end
    end
    assign full = (count == DEPTH);
    assign empty = (count == 0);
endmodule
```

---

## 3. Integrating FIFO with UART
### 3.1 UART Top Module with FIFO
We modify the **uart_top** module to include FIFO buffers for TX and RX:

```systemverilog
module uart_top_fifo (
    input logic clk, rst, start,
    input logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic tx_busy, rx_valid
);
    logic tx_serial;
    logic fifo_tx_empty, fifo_rx_full;
    
    // TX FIFO
    uart_fifo tx_fifo (
        .clk(clk), .rst(rst), .wr_en(start), .rd_en(!tx_busy),
        .data_in(tx_data), .data_out(), .full(), .empty(fifo_tx_empty)
    );
    
    // UART Transmitter
    uart_tx tx_inst (
        .clk(clk), .rst(rst), .start(!fifo_tx_empty),
        .data_in(tx_data), .tx(tx_serial), .busy(tx_busy)
    );
    
    // UART Receiver
    uart_rx rx_inst (
        .clk(clk), .rst(rst), .rx(tx_serial),
        .data_out(rx_data), .valid(rx_valid)
    );
    
    // RX FIFO
    uart_fifo rx_fifo (
        .clk(clk), .rst(rst), .wr_en(rx_valid), .rd_en(1'b1),
        .data_in(rx_data), .data_out(rx_data), .full(fifo_rx_full), .empty()
    );
endmodule
```

---

## 4. Simulating UART with FIFO
### 4.1 Testbench for UART with FIFO

```systemverilog
module uart_top_fifo_tb;
    logic clk, rst, start;
    logic [7:0] tx_data, rx_data;
    logic tx_busy, rx_valid;
    
    // Instantiate UART Top Module with FIFO
    uart_top_fifo uut (
        .clk(clk), .rst(rst), .start(start),
        .tx_data(tx_data), .rx_data(rx_data),
        .tx_busy(tx_busy), .rx_valid(rx_valid)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; start = 0; tx_data = 8'h00;
        #10 rst = 0;
        
        // Transmit multiple bytes
        #10 tx_data = 8'h48; start = 1; #10 start = 0;
        #20 tx_data = 8'h65; start = 1; #10 start = 0;
        #20 tx_data = 8'h6C; start = 1; #10 start = 0;
        #20 tx_data = 8'h6C; start = 1; #10 start = 0;
        #20 tx_data = 8'h6F; start = 1; #10 start = 0;
        
        $stop;
    end
endmodule
```

---

## 5. Key Takeaways
- **FIFO buffers** enhance UART communication by buffering data for smooth operation.
- **TX FIFO** prevents transmission stalls by preloading data.
- **RX FIFO** prevents data loss by temporarily storing received data.
- **Integration with UART** ensures efficient serial communication.

### 🚀 Next Steps
- Implement **configurable FIFO sizes**.
- Add **flow control** to manage FIFO fullness.

---

This concludes **Day 29: Implementing a FIFO Buffer for UART**. Happy coding! 🚀

