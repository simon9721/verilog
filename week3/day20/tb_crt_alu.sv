module alu_tb;
    // Declare test signals
    logic [3:0] a, b;
    logic [2:0] op;
    logic [3:0] result;
    
    // Instantiate the ALU module
    alu uut (
        .a(a), .b(b), .op(op), .result(result)
    );
    
    // Define functional coverage
    covergroup alu_coverage;
        coverpoint a {
            bins all_values[] = {[0:15]}; // Track all possible input values
        }
        coverpoint b {
            bins all_values[] = {[0:15]};
        }
        coverpoint op {
            bins valid_ops[] = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100}; // Only valid operations
        }
        cross a, b, op; // Capture interactions between inputs and operations
    endgroup
    
    alu_coverage cg = new();
    
    // Apply test vectors and collect coverage data
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | OP=%b | RESULT=%b", $time, a, b, op, result);
        
        repeat (50) begin
            assert(std::randomize(a, b, op) with {
                a inside {[0:15]};
                b inside {[0:15]};
                op inside {[0:4]};
            }) else $error("Randomization failed");
            
            cg.sample(); // Capture coverage data
            #10;
        end
        
        $stop;
    end
endmodule