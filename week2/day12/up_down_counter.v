module up_down_counter (
    input wire clk,
    input wire rst,
    input wire dir,      // Direction control: 1 = up, 0 = down
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'b0000;  // Reset counter to 0
    else if (dir)
        count <= count + 1;  // Count up
    else
        count <= count - 1;  // Count down
end

endmodule