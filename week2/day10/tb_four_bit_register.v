module testbench;
    reg clk, rst, load;
    reg [3:0] d;
    wire [3:0] q;
    
    four_bit_register uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("four_bit_register.vcd");
        $dumpvars(0, testbench);
        
        // Initialize signals
        clk = 0; rst = 1; load = 0; d = 4'b0000;
        #10 rst = 0;
        
        // Load 1010 into the register
        #10 load = 1; d = 4'b1010;
        #10 load = 0;
        
        // Load 1100 into the register
        #10 load = 1; d = 4'b1100;
        #10 load = 0;
        
        // Reset
        #10 rst = 1;
        #10 rst = 0;
        
        #20 $finish;
    end
endmodule