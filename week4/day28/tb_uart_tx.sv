module uart_tx_tb;
    logic clk, rst, start;
    logic [7:0] data_in;
    logic tx, busy;
    
    // Instantiate UART TX module
    uart_tx uut (
        .clk(clk), .rst(rst), .start(start),
        .data_in(data_in), .tx(tx), .busy(busy)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; start = 0; data_in = 8'h00;
        #10 rst = 0;
        
        // Transmit 'A' (ASCII 0x41)
        #10 data_in = 8'h41; start = 1; #10 start = 0;
        
        // Transmit 'B' (ASCII 0x42)
        #100 data_in = 8'h42; start = 1; #10 start = 0;
        
        $stop;
    end
endmodule