# Day 27: Design a UART Receiver

## Overview
A **Universal Asynchronous Receiver Transmitter (UART)** receiver (UART RX) is responsible for decoding serial data received from a transmitter. The receiver detects the start bit, reads the data bits, checks the parity (if used), and verifies the stop bit. In this session, we will implement a **UART receiver module** and simulate data reception from the UART transmitter.

---

## 1. Understanding UART Reception
### 1.1 UART Reception Process
A UART receiver follows these steps:
- **Wait for the start bit (`0`)** to indicate incoming data.
- **Read the data bits** at the correct baud rate timing.
- **Check the parity bit (if enabled)** for error detection.
- **Verify the stop bit (`1`)** to confirm transmission completion.

### 1.2 Synchronization and Sampling
- The receiver synchronizes to the **start bit** and samples the data at the middle of each bit period.
- A **state machine** is used to track the reception process.

---

## 2. Implementing the UART Receiver
### 2.1 UART RX Module
Below is the Verilog implementation of a **UART receiver**:

```systemverilog
module uart_rx (
    input logic clk, rst, rx,
    output logic [7:0] data_out,
    output logic valid
);
    typedef enum logic [2:0] {IDLE, START, DATA, PARITY, STOP} state_t;
    state_t state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;
    logic parity_bit;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            valid <= 0;
            bit_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (!rx) begin // Detect start bit
                        state <= START;
                        bit_count <= 0;
                    end
                end
                START: begin
                    state <= DATA;
                end
                DATA: begin
                    shift_reg <= {rx, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) state <= PARITY;
                end
                PARITY: begin
                    parity_bit <= ^shift_reg; // Calculate received parity
                    state <= STOP;
                end
                STOP: begin
                    if (rx) begin // Verify stop bit
                        data_out <= shift_reg;
                        valid <= 1;
                    end
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
```

---

## 3. Simulating UART Reception
### 3.1 UART RX Testbench
To verify UART reception, we simulate receiving data from the UART TX module:

```systemverilog
module uart_rx_tb;
    logic clk, rst, rx;
    logic [7:0] data_out;
    logic valid;
    
    // Instantiate UART RX module
    uart_rx uut (
        .clk(clk), .rst(rst), .rx(rx),
        .data_out(data_out), .valid(valid)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; rx = 1;
        #10 rst = 0;
        
        // Simulate receiving 'A' (ASCII 0x41, 8'h41)
        #10 rx = 0; // Start bit
        #10 rx = 1; // Bit 0
        #10 rx = 0; // Bit 1
        #10 rx = 0; // Bit 2
        #10 rx = 0; // Bit 3
        #10 rx = 0; // Bit 4
        #10 rx = 1; // Bit 5
        #10 rx = 0; // Bit 6
        #10 rx = 0; // Bit 7
        #10 rx = 1; // Parity bit
        #10 rx = 1; // Stop bit
        
        $stop;
    end
endmodule
```

---

## 4. Key Takeaways
- **UART reception** involves detecting start, reading data, and verifying stop bits.
- **State machines** help handle bit-by-bit reception efficiently.
- **Testbenches** validate the correct reception of data frames.

### 🚀 Next Steps
- Modify the receiver to support different baud rates.
- Integrate the UART TX and RX modules for a full communication test.

---

This concludes **Day 27: Design a UART Receiver**. Keep coding! 🚀

