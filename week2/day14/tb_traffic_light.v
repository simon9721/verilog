`timescale 1ns / 1ps  // Time precision and unit

module traffic_light_tb;
    
    // Testbench signals
    reg clk;
    reg reset;
    wire [1:0] light;

    // Instantiate the traffic_light module (MUT - Module Under Test)
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .light(light)
    );

    // Clock generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;  // Apply reset
        #10;       // Wait for 10 ns
        reset = 0;  // Release reset

        // Observe state transitions
        #50;  // Run simulation for 50 ns

        $finish;  // End simulation
    end

    // Monitor output changes
    initial begin
        $monitor("Time = %0t | Reset = %b | Light = %b", $time, reset, light);
    end

endmodule
