module shift_register (
    input wire clk,       // Clock signal
    input wire rst,       // Asynchronous reset
    input wire si,        // Serial input
    output reg [3:0] q    // Parallel output (4-bit)
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000; // Reset all outputs
        else
            q <= {q[2:0], si}; // Shift left and insert new bit
    end
endmodule