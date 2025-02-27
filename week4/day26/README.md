# Day 26: Design a UART Transmitter

## Overview
A **Universal Asynchronous Receiver Transmitter (UART)** is a widely used serial communication protocol. The transmitter (UART TX) is responsible for encoding data into a serial bitstream, including start, data, parity, and stop bits. In this session, we will implement a **UART transmitter module** and simulate data transmission.

---

## 1. Understanding UART Transmission
### 1.1 UART Frame Structure
A UART frame consists of:
- **Start Bit (1 bit)**: Always `0`, indicating the beginning of transmission.
- **Data Bits (5-8 bits)**: The actual data to be transmitted.
- **Parity Bit (Optional, 1 bit)**: Used for error detection.
- **Stop Bit (1-2 bits)**: Always `1`, signaling the end of the transmission.

### 1.2 Transmission Timing
- Baud rate determines the **bit period**.
- The transmitter shifts bits out at the correct timing intervals.

---

## 2. Implementing the UART Transmitter
### 2.1 UART TX Module
Below is the Verilog implementation of a **UART transmitter**:

```systemverilog
module uart_tx (
    input logic clk, rst, start,
    input logic [7:0] data_in,
    output logic tx,
    output logic busy
);
    typedef enum logic [2:0] {IDLE, START, DATA, PARITY, STOP} state_t;
    state_t state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;
    logic parity_bit;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            busy <= 0;
            bit_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        shift_reg <= data_in;
                        parity_bit <= ^data_in; // Even parity
                        tx <= 0; // Start bit
                        busy <= 1;
                        state <= START;
                    end
                end
                START: begin
                    state <= DATA;
                    bit_count <= 0;
                end
                DATA: begin
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) state <= PARITY;
                end
                PARITY: begin
                    tx <= parity_bit;
                    state <= STOP;
                end
                STOP: begin
                    tx <= 1; // Stop bit
                    busy <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
```

---

## 3. Simulating UART Transmission
### 3.1 UART TX Testbench
To verify UART transmission, we simulate different data values:

```systemverilog
module uart_tx_tb;
    logic clk, rst, start;
    logic [7:0] data_in;
    logic tx, busy;
    
    // Instantiate UART TX module
    uart_tx uut (
        .clk(clk), .rst(rst), .start(start),
        .data_in(data_in), .tx(tx), .busy(busy)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; start = 0; data_in = 8'h00;
        #10 rst = 0;
        
        // Transmit 'A' (ASCII 0x41)
        #10 data_in = 8'h41; start = 1; #10 start = 0;
        
        // Transmit 'B' (ASCII 0x42)
        #100 data_in = 8'h42; start = 1; #10 start = 0;
        
        $stop;
    end
endmodule
```

---

## 4. Key Takeaways
- **UART transmission** includes start, data, parity, and stop bits.
- **State machines** control data transmission efficiently.
- **Testbenches** validate serial data transmission correctness.

### 🚀 Next Steps
- Modify the transmitter to support different parity types.
- Implement a **UART receiver** to complete the communication system.

---

This concludes **Day 26: Design a UART Transmitter**. Keep coding! 🚀

