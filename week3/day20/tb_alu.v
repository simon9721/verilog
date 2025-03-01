module alu_tb;
    reg [3:0] a, b;
    reg [2:0] op;
    wire [3:0] result;
    
    // Instantiate the ALU module
    alu uut (
        .a(a), .b(b), .op(op), .result(result)
    );
    
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        // Test Addition
        a = 4'b0011; b = 4'b0001; op = 3'b000; #10;
        
        // Test Subtraction
        a = 4'b0100; b = 4'b0001; op = 3'b001; #10;
        
        // Test AND
        a = 4'b1100; b = 4'b1010; op = 3'b010; #10;
        
        // Test OR
        a = 4'b1100; b = 4'b1010; op = 3'b011; #10;
        
        // Test XOR
        a = 4'b1100; b = 4'b1010; op = 3'b100; #10;
        
        $stop;
    end
endmodule