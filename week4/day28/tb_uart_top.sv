module uart_top_tb;
    logic clk, rst, start;
    logic [7:0] tx_data, rx_data;
    logic tx_busy, rx_valid;
    
    // Instantiate UART Top-Level Module
    uart_top uut (
        .clk(clk), .rst(rst), .start(start),
        .tx_data(tx_data), .rx_data(rx_data),
        .tx_busy(tx_busy), .rx_valid(rx_valid)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; start = 0; tx_data = 8'h00;
        #10 rst = 0;
        
        // Transmit 'H' (ASCII 0x48)
        #10 tx_data = 8'h48; start = 1; #10 start = 0;
        
        // Wait for reception
        #100;
        
        // Transmit 'I' (ASCII 0x49)
        #100 tx_data = 8'h49; start = 1; #10 start = 0;
        
        #200
        
        $stop;
    end
endmodule