module four_bit_register (
    input wire clk,         // Clock signal
    input wire rst,         // Reset signal
    input wire load,        // Load enable
    input wire [3:0] d,     // 4-bit input data
    output reg [3:0] q      // 4-bit stored output
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;  // Reset the register
        else if (load)
            q <= d;       // Load new data
    end
endmodule