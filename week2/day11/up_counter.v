module up_counter (
    input wire clk,       // Clock signal
    input wire reset,     // Active-high reset
    output reg [3:0] count // 4-bit count output
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000;  // Reset the counter to 0
        else
            count <= count + 1; // Increment count on clock edge
    end

endmodule