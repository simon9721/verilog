module ram_tb;
    reg clk;
    reg we;
    reg [3:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    // Instantiate the RAM module
    simple_ram uut (
        .clk(clk),
        .we(we),
        .addr(address),
        .din(data_in),
        .dout(data_out)
    );
    
    always #5 clk = ~clk; // Clock generator
    
    initial begin
        clk = 0;
        
        // Write operations
        we = 1; address = 4'h0; data_in = 8'hAA; #10;
        we = 1; address = 4'h1; data_in = 8'hBB; #10;
        we = 1; address = 4'h2; data_in = 8'hCC; #10;
        
        // Read operations
        we = 0; address = 4'h0; #10;
        we = 0; address = 4'h1; #10;
        we = 0; address = 4'h2; #10;
        
        $stop;
    end
endmodule