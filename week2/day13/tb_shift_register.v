module tb_shift_register;
    reg clk, rst, si;
    wire [3:0] q;
    
    // Instantiate the shift register
    shift_register uut (
        .clk(clk),
        .rst(rst),
        .si(si),
        .q(q)
    );
    
    // Clock generation (10ns period)
    always #5 clk = ~clk;
    
    initial begin
        // Initialize inputs
        clk = 0; rst = 1; si = 0;
        #10 rst = 0; // Release reset
        
        // Apply serial data: 1011
        #10 si = 1;
        #10 si = 0;
        #10 si = 1;
        #10 si = 1;
        
        // Observe parallel output
        #50 $stop;
    end
    
    initial begin
        $monitor("Time=%0t | SI=%b | Q=%b", $time, si, q);
    end
endmodule