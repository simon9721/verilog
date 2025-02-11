module jk_flip_flop (
    input wire clk,
    input wire rst,
    input wire J,
    input wire K,
    output reg Q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 0;
    else begin
        case ({J, K})
            2'b00: Q <= Q;   // Hold State
            2'b01: Q <= 0;   // Reset
            2'b10: Q <= 1;   // Set
            2'b11: Q <= ~Q;  // Toggle
        endcase
    end
end

endmodule