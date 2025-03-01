module uart_top (
    input logic clk, rst, start,
    input logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic tx_busy, rx_valid
);
    logic tx_serial;
    
    // Instantiate UART Transmitter
    uart_tx tx_inst (
        .clk(clk), .rst(rst), .start(start),
        .data_in(tx_data), .tx(tx_serial), .busy(tx_busy)
    );
    
    // Instantiate UART Receiver
    uart_rx rx_inst (
        .clk(clk), .rst(rst), .rx(tx_serial),
        .data_out(rx_data), .valid(rx_valid)
    );
endmodule