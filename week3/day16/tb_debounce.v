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
        #5 noisy_in = 1; // Stable high
        #100 noisy_in = 0; // Stable low
        #15 noisy_in = 1;
        #5 noisy_in = 0;
        #5 noisy_in = 1;
        #5 noisy_in = 0;
        
        #50 $stop;
    end
endmodule