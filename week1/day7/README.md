# Day 7: Combine Adders into a 4-bit Ripple Carry Adder

## Objective
Today, we will extend our knowledge of adders by chaining four 1-bit full adders to create a **4-bit ripple carry adder**. This design allows us to add two 4-bit numbers and produce a 5-bit result (including the carry-out bit).

## Understanding the Ripple Carry Adder
A **ripple carry adder (RCA)** is constructed by cascading multiple 1-bit full adders in sequence. The carry-out from one full adder serves as the carry-in for the next stage.

### 1-bit Full Adder Recap
A full adder takes three inputs:
- `a`: 1-bit input
- `b`: 1-bit input
- `cin`: Carry-in from the previous stage

And it produces two outputs:
- `sum`: The sum of the inputs
- `cout`: The carry-out to the next stage

#### Verilog Implementation of a 1-bit Full Adder:
```verilog
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
```

## Chaining 1-bit Full Adders to Create a 4-bit RCA
To construct a **4-bit ripple carry adder**, we instantiate four **full adders** and chain their carry outputs to the carry inputs of the next stage.

### Verilog Implementation of a 4-bit Ripple Carry Adder
```verilog
module ripple_carry_adder (
    input [3:0] A,  // 4-bit input A
    input [3:0] B,  // 4-bit input B
    input cin,      // Carry-in
    output [3:0] sum, // 4-bit sum output
    output cout      // Final carry-out
);
    wire c1, c2, c3; // Intermediate carry signals

    full_adder fa0 (A[0], B[0], cin, sum[0], c1);
    full_adder fa1 (A[1], B[1], c1, sum[1], c2);
    full_adder fa2 (A[2], B[2], c2, sum[2], c3);
    full_adder fa3 (A[3], B[3], c3, sum[3], cout);
endmodule
```

## Testing the 4-bit Ripple Carry Adder
We will create a **testbench** to verify our design by adding two 4-bit numbers, such as `4'b1010 + 4'b0101`.

### Verilog Testbench:
```verilog
module test_ripple_carry_adder;
    reg [3:0] A, B;
    reg cin;
    wire [3:0] sum;
    wire cout;
    
    ripple_carry_adder rca (A, B, cin, sum, cout);
    
    initial begin
        $monitor("A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", A, B, cin, sum, cout);
        
        A = 4'b1010; B = 4'b0101; cin = 0; #10;
        A = 4'b1100; B = 4'b0011; cin = 0; #10;
        A = 4'b1111; B = 4'b0001; cin = 0; #10;
        
        $finish;
    end
endmodule
```

## Expected Output
```
A = 1010, B = 0101, Cin = 0, Sum = 1111, Cout = 0
A = 1100, B = 0011, Cin = 0, Sum = 1111, Cout = 0
A = 1111, B = 0001, Cin = 0, Sum = 0000, Cout = 1
```

## Key Takeaways
- A **ripple carry adder** consists of chained **full adders**.
- The **carry-out** of one stage serves as the **carry-in** for the next stage.
- The final **carry-out** indicates overflow in unsigned addition.

### Next Steps
- Modify the design to handle **signed numbers**.
- Explore **carry-lookahead adders (CLAs)** to optimize addition speed.

Test your design and experiment with different inputs. 🚀 Happy coding!

