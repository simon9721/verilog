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