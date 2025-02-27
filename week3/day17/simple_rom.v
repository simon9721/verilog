module simple_rom (
    input wire [3:0] addr,  // 4-bit address (16 locations)
    output reg [7:0] data   // 8-bit output data
);
    // Declare ROM memory (16 locations, 8-bit each)
    reg [7:0] rom_memory [0:15];
    
    // Initialize ROM contents
    initial begin
        rom_memory[0]  = 8'hA1;
        rom_memory[1]  = 8'hB2;
        rom_memory[2]  = 8'hC3;
        rom_memory[3]  = 8'hD4;
        rom_memory[4]  = 8'hE5;
        rom_memory[5]  = 8'hF6;
        rom_memory[6]  = 8'h07;
        rom_memory[7]  = 8'h18;
        rom_memory[8]  = 8'h29;
        rom_memory[9]  = 8'h3A;
        rom_memory[10] = 8'h4B;
        rom_memory[11] = 8'h5C;
        rom_memory[12] = 8'h6D;
        rom_memory[13] = 8'h7E;
        rom_memory[14] = 8'h8F;
        rom_memory[15] = 8'h90;
    end
    
    // Read operation
    always @(*) begin
        data = rom_memory[addr];
    end
endmodule