module uart_rx_tb;
    logic clk, rst, rx;
    logic [7:0] data_out;
    logic valid;
    
    // Instantiate UART RX module
    uart_rx uut (
        .clk(clk), .rst(rst), .rx(rx),
        .data_out(data_out), .valid(valid)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0; rst = 1; rx = 1;
        #10 rst = 0;
        
        // Simulate receiving 'A' (ASCII 0x41, 8'h41)
        #10 rx = 0; // Start bit
        #10 rx = 1; // Bit 0
        #10 rx = 0; // Bit 1
        #10 rx = 0; // Bit 2
        #10 rx = 0; // Bit 3
        #10 rx = 0; // Bit 4
        #10 rx = 1; // Bit 5
        #10 rx = 0; // Bit 6
        #10 rx = 0; // Bit 7
        #10 rx = 1; // Parity bit
        #10 rx = 1; // Stop bit
        
        $stop;
    end
endmodule