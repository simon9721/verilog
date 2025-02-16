module tb_up_counter;
    reg clk;
    reg reset;
    wire [3:0] count;

    up_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle every 5 time units

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0; // Deassert reset after 10 time units

        // Run simulation for 100 time units
        #100;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | Count=%b", $time, count);
    end
endmodule