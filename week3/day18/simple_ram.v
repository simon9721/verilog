module simple_ram (
    input wire clk,             // Clock signal
    input wire we,              // Write enable (1 = write, 0 = read)
    input wire [3:0] addr,      // 4-bit address (16 locations)
    input wire [7:0] din,       // 8-bit input data
    output reg [7:0] dout       // 8-bit output data
);
    // Declare RAM memory (16 locations, 8-bit each)
    reg [7:0] ram_memory [0:15];
    
    always @(posedge clk) begin
        if (we) 
            ram_memory[addr] <= din;  // Write operation
        else 
            dout <= ram_memory[addr]; // Read operation
    end
endmodule