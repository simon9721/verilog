`timescale 1ns / 1ps
module tb_d_flip_flop();
    
    reg clk;
    reg rst;
    reg d;
    wire q;
    
    // Instantiate the D flip-flop
    d_flip_flop uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns period (100MHz clock)
    
    initial begin
        // Initialize signals
        clk = 0; rst = 1; d = 0;
        #10 rst = 0; // Release reset
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 1;
        #10 d = 0;
        #10 $stop;
    end
    
endmodule