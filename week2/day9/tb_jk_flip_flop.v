`timescale 1ns / 1ps

module jk_flip_flop_tb;
    reg clk, rst, J, K;
    wire Q;
    
    jk_flip_flop uut (
        .clk(clk),
        .rst(rst),
        .J(J),
        .K(K),
        .Q(Q)
    );
    
    always #5 clk = ~clk; // Generate clock signal
    
    initial begin
        $dumpfile("jk_flip_flop_tb.vcd");
        $dumpvars(0, jk_flip_flop_tb);
        
        clk = 0; rst = 1; J = 0; K = 0;
        #10 rst = 0; // Deassert reset
        
        #10 J = 0; K = 0; // Hold State
        #10 J = 0; K = 1; // Reset
        #10 J = 1; K = 0; // Set
        #10 J = 1; K = 1; // Toggle
        #10 J = 0; K = 0; // Hold State
        #10 $finish;
    end
    
endmodule