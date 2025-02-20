# Day 15: Design a Sequence Detector (Mealy Machine)

## Introduction
A **sequence detector** is a finite state machine (FSM) that identifies a specific sequence of bits in a serial data stream. In this session, we will design a **Mealy Machine** to detect the sequence "1101".

## Mealy Machine Overview
A Mealy machine outputs based on both the **current state** and the **input**. This differs from a Moore machine, where outputs depend only on the state. The advantage of the Mealy approach is that it can respond faster since outputs can change within the same clock cycle.

### FSM Design for Sequence "1101"
- The FSM should recognize "1101" in a serial bitstream.
- The output should be `1` when the sequence "1101" is detected; otherwise, it should remain `0`.
- The FSM should be able to handle overlapping sequences.

## 1. Define States
We define the following states:
- **S0**: Initial state (no bits matched yet)
- **S1**: "1" detected
- **S2**: "11" detected
- **S3**: "110" detected
- **S4**: "1101" detected (output `1`, then return to S1 if the last bit was `1`, else go to S0)

## 2. State Transition Diagram
The FSM transitions as follows:
- Start at **S0**.
- If `1` is received, move to **S1**.
- If another `1` is received, move to **S2**.
- If `0` is received, move to **S3**.
- If `1` is received, move to **S4** (detect sequence, output `1`).
- Continue processing the next input while handling overlaps.

## 3. Verilog Implementation
### Sequence Detector (Mealy Machine)
```verilog
module sequence_detector (
    input wire clk,
    input wire rst,
    input wire in,
    output reg detected
);

    typedef enum reg [2:0] {S0, S1, S2, S3, S4} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S2 : S3;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        detected = (state == S3 && in);
    end

endmodule
```

## 4. Testbench for Simulation
```verilog
module tb_sequence_detector;
    reg clk, rst, in;
    wire detected;
    
    sequence_detector uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .detected(detected)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period 10 units
    end

    initial begin
        rst = 1; in = 0;
        #10 rst = 0;
        
        // Test sequence 1101
        #10 in = 1;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #10 in = 0; // Resetting input to observe overlap handling
        #10 in = 1;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        
        #20 $stop;
    end
endmodule
```

## 5. Simulation and Analysis
- The testbench initializes the FSM and feeds it different input sequences.
- The `detected` signal should go high when "1101" is recognized.
- Observe waveforms to verify correct state transitions.

## Summary
- Implemented a **Mealy Machine** sequence detector.
- Designed an FSM for detecting "1101".
- Verified functionality using a testbench.

### Next Steps
- Extend the design to detect different sequences.
- Implement a **Moore machine** version for comparison.
- Test with more complex overlapping patterns.

---
🎯 **Task**: Modify the testbench to include additional sequences and analyze the output!

