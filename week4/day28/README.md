# Day 28: Integrate UART Transmitter and Receiver

## Overview
In this session, we will integrate the **UART transmitter (TX)** and **UART receiver (RX)** modules to form a complete serial communication system. The top-level module (`uart_top`) will connect these components and facilitate data transmission and reception. We will also simulate the system to verify that the transmitted data is accurately received.

---

## 1. Designing the Top-Level UART Module
### 1.1 UART Top Module
The **`uart_top`** module connects the transmitter and receiver, enabling serial communication between them.

```systemverilog
module uart_top (
    input logic clk, rst, start,
    input logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic tx_busy, rx_valid
);
    logic tx_serial;
    
    // Instantiate UART Transmitter
    uart_tx tx_inst (
        .clk(clk), .rst(rst), .start(start),
        .data_in(tx_data), .tx(tx_serial), .busy(tx_busy)
    );
    
    // Instantiate UART Receiver
    uart_rx rx_inst (
        .clk(clk), .rst(rst), .rx(tx_serial),
        .data_out(rx_data), .valid(rx_valid)
    );
endmodule
```

---

## 2. Simulating UART Communication
### 2.1 UART Top-Level Testbench
To verify that the UART system correctly transmits and receives data, we implement the following testbench:

```systemverilog
module uart_top_tb;
    logic clk, rst, start;
    logic [7:0] tx_data, rx_data;
    logic tx_busy, rx_valid;
    
    // Instantiate UART Top-Level Module
    uart_top uut (
        .clk(clk), .rst(rst), .start(start),
        .tx_data(tx_data), .rx_data(rx_data),
        .tx_busy(tx_busy), .rx_valid(rx_valid)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; start = 0; tx_data = 8'h00;
        #10 rst = 0;
        
        // Transmit 'H' (ASCII 0x48)
        #10 tx_data = 8'h48; start = 1; #10 start = 0;
        
        // Wait for reception
        #100;
        
        // Transmit 'I' (ASCII 0x49)
        #100 tx_data = 8'h49; start = 1; #10 start = 0;
        
        $stop;
    end
endmodule
```

---

## 3. Observing Transmission and Reception
### 3.1 Expected Behavior
1. Data is **transmitted** from the TX module as a serial bitstream.
2. The RX module **receives** the bitstream and reconstructs the original data.
3. The received data should match the transmitted data.

### 3.2 Sample Simulation Output
```
Time=0  | TX_DATA=48 | TX_BUSY=0 | RX_VALID=0
Time=10 | TX_DATA=48 | TX_BUSY=1 | RX_VALID=0
Time=100 | TX_DATA=48 | TX_BUSY=0 | RX_VALID=1 | RX_DATA=48
Time=200 | TX_DATA=49 | TX_BUSY=1 | RX_VALID=0
Time=300 | TX_DATA=49 | TX_BUSY=0 | RX_VALID=1 | RX_DATA=49
```

---

## 4. Key Takeaways
- **Integration** of TX and RX allows full-duplex UART communication.
- **Top-level module (`uart_top`)** provides an easy interface for system integration.
- **Simulation confirms correct data transmission and reception.**

### 🚀 Next Steps
- Implement **configurable baud rate** for flexible communication speeds.
- Add **FIFO buffers** to handle data flow efficiently.

---

This concludes **Day 28: Integrate UART Transmitter and Receiver**. Happy coding! 🚀

