module d_flip_flop (
    input wire clk,      // Clock signal
    input wire rst,      // Asynchronous reset
    input wire d,        // Data input
    output reg q        // Output Q
);
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0; // Reset Q to 0
        else
            q <= d; // Capture input D at rising clock edge
    end
    
endmodule