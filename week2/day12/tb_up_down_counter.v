module tb_up_down_counter;

reg clk, rst, dir;
wire [3:0] count;

// Instantiate the counter module
up_down_counter uut (
    .clk(clk),
    .rst(rst),
    .dir(dir),
    .count(count)
);

// Clock Generation
always #5 clk = ~clk; // 10ns clock period

initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    dir = 1;
    #10 rst = 0;  // Deassert reset

    // Count up for 5 cycles
    #50 dir = 0;  // Switch to count down

    // Count down for 5 cycles
    #50 $stop;  // End simulation
end

endmodule