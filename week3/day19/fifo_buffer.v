module fifo_buffer (
    input wire clk, rst,           // Clock and reset
    input wire wr_en, rd_en,       // Write and read enable
    input wire [7:0] din,          // Data input
    output reg [7:0] dout,         // Data output
    output reg full, empty         // Status flags
);
    reg [7:0] fifo_memory [0:15];  // 16-byte FIFO buffer
    reg [3:0] write_ptr = 0;       // Write pointer (4-bit for 16-depth FIFO)
    reg [3:0] read_ptr = 0;        // Read pointer (4-bit for 16-depth FIFO)
    reg [4:0] count = 0;           // Track number of elements (5-bit to hold values 0-16)
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                fifo_memory[write_ptr] <= din;
                write_ptr <= write_ptr + 1; // Wrap automatically due to 4-bit
                count <= count + 1;
            end

            // Read operation
            if (rd_en && !empty) begin
                dout <= fifo_memory[read_ptr];  // Output correct value
                read_ptr <= read_ptr + 1; // Wrap automatically due to 4-bit
                count <= count - 1;
            end

            // Update status flags **immediately**
            full <= (count == 16);  // Full when the next write would exceed size
            empty <= (count == 0);  // Empty when no elements left
        end
    end
endmodule
