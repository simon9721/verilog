module rom_tb;
    reg [3:0] address;
    wire [7:0] data_out;
    
    // Instantiate the ROM module
    simple_rom uut (
        .addr(address),
        .data(data_out)
    );
    
    initial begin
        $monitor("Time=%0t | Addr=%h | Data=%h", $time, address, data_out);
        
        address = 4'h0; #10;
        address = 4'h1; #10;
        address = 4'h2; #10;
        address = 4'h3; #10;
        address = 4'h4; #10;
        address = 4'h5; #10;
        address = 4'h6; #10;
        address = 4'h7; #10;
        address = 4'h8; #10;
        address = 4'h9; #10;
        address = 4'hA; #10;
        address = 4'hB; #10;
        address = 4'hC; #10;
        address = 4'hD; #10;
        address = 4'hE; #10;
        address = 4'hF; #10;
        
        $stop;
    end
endmodule