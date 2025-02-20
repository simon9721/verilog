# Day 16: Implement a Debounce Circuit

## Introduction
Mechanical switches, when pressed or released, do not produce a clean transition from high to low (or vice versa). Instead, they generate multiple spurious transitions due to mechanical bouncing. To prevent unintended multiple detections, a **debounce circuit** is used to stabilize the switch output.

In this lecture, we will design a **debounce module** using a counter-based approach and verify its performance by simulating noisy switch input signals.

---

## 1. Debounce Circuit Concept
A debounce circuit removes the unwanted oscillations caused by mechanical bouncing. There are several ways to implement a debounce circuit, including:
- **RC Filtering**: Using a resistor-capacitor network to smooth the signal.
- **Flip-Flop Synchronization**: Using D flip-flops to synchronize the signal.
- **Counter-Based Approach**: Using a counter to detect a stable level over a set period.

We will focus on the **counter-based debounce method**, as it is a reliable digital solution for FPGA and ASIC implementations.

---

## 2. Counter-Based Debounce Logic
### **How It Works**
1. Sample the noisy switch signal on each clock cycle.
2. Use a counter to monitor how long the signal remains stable.
3. If the signal remains constant for a predefined period (e.g., 10ms), update the debounced output.
4. Otherwise, reset the counter and continue monitoring.

### **Key Parameters**
- **Clock Frequency**: Determines the counter resolution.
- **Debounce Time**: Defines how long the signal must remain stable before changing states.
- **Counter Width**: Needs to be sufficient to count for the required debounce time.

---

## 3. Verilog Implementation of the Debounce Module
The following Verilog module implements a **debounce circuit** using a counter.

```verilog
module debounce (
    input wire clk,         // System clock
    input wire rst,         // Reset signal
    input wire noisy_in,    // Noisy switch input
    output reg clean_out    // Debounced output
);

    parameter COUNTER_MAX = 100000; // Adjust based on clock frequency
    reg [16:0] counter; // Counter register
    reg stable_state; // Tracks last stable state

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            stable_state <= 0;
            clean_out <= 0;
        end else begin
            if (noisy_in == stable_state) begin
                counter <= 0; // Reset counter if input remains the same
            end else begin
                counter <= counter + 1;
                if (counter >= COUNTER_MAX) begin
                    stable_state <= noisy_in;
                    clean_out <= noisy_in;
                    counter <= 0;
                end
            end
        end
    end
endmodule
```

---

## 4. Simulating Noisy Input Signals
To validate our debounce circuit, we need to simulate **noisy switch input** and observe how the module stabilizes the output.

### **Testbench for Simulation**
```verilog
module debounce_tb;
    reg clk;
    reg rst;
    reg noisy_in;
    wire clean_out;
    
    debounce uut (
        .clk(clk),
        .rst(rst),
        .noisy_in(noisy_in),
        .clean_out(clean_out)
    );

    // Generate clock signal
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        noisy_in = 0;
        #10 rst = 0;

        // Simulating a noisy switch press
        #15 noisy_in = 1;
        #5 noisy_in = 0;
        #5 noisy_in = 1;
        #5 noisy_in = 0;
        #50 noisy_in = 1; // Stable high
        #100 noisy_in = 0; // Stable low
        
        #100 $stop;
    end
endmodule
```

---

## 5. Observing the Results
Using a **waveform viewer (GTKWave, ModelSim, etc.)**, you should observe:
1. **Noisy input changes multiple times** before stabilizing.
2. **Counter increments when input changes**.
3. **Debounced output updates only when input remains stable for the set duration**.

---

## 6. Key Takeaways
- **Mechanical switches introduce noise (bouncing), requiring debounce logic.**
- **Counter-based debouncing ensures stability by waiting for a signal to be constant for a specific period.**
- **Simulation helps visualize the debounce effect and verify correctness before FPGA implementation.**

---

### **Next Steps**
- Experiment with different **COUNTER_MAX** values to observe how debounce timing affects response.
- Modify the circuit to debounce multiple switches simultaneously.
- Implement a **FSM (Finite State Machine)**-based debounce for enhanced control.

Great job! 🚀 Now, try implementing this on an FPGA and testing with a real push button.

