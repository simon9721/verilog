`timescale 1ns / 1ps

module fifo_buffer_tb;

    // Testbench signals
    logic clk, rst;
    logic wr_en, rd_en;
    logic [7:0] din;
    logic [7:0] dout;
    logic full, empty;

    // Instantiate the FIFO module
    fifo_buffer uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    // Testbench logic
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 8'b0;
        
        // Apply reset
        #10;
        rst = 0;
        #10;

        // Test 1: Write and Read a Single Value
        din = 8'hA5;   // Test value
        wr_en = 1;     // Enable write
        #10;
        wr_en = 0;     // Disable write
        #10
        
        rd_en = 1;     // Enable read
        #10;
        rd_en = 0;     // Disable read
        #10;

        // Test 2: Fill the FIFO
        $display("Filling FIFO...");
        for (int i = 0; i < 16; i++) begin
            din = i + 1; // Load data 1, 2, 3, ..., 16
            wr_en = 1;
            #10;
        end
        wr_en = 0;
        #10;

        // Test 3: Attempt to Write When Full
        if (full) 
            $display("FIFO is full. Cannot write more data.");
        else
            $display("ERROR: FIFO should be full!");
        
        #10;
        // Test 4: Read All Data
        $display("Reading all FIFO data...");
        for (int i = 0; i < 16; i++) begin
            rd_en = 1;
            #10;
        end
        rd_en = 0;
        #10;

        // Test 5: Attempt to Read When Empty
        if (empty) 
            $display("FIFO is empty. Cannot read more data.");
        else
            $display("ERROR: FIFO should be empty!");

        // End simulation
        $display("Test Completed.");
        $finish;
    end

endmodule
