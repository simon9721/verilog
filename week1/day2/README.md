# Day 2: Data Types and Operators

## Verilog Data Types
Verilog provides several data types to describe hardware. The two most commonly used types are **`wire`** and **`reg`**.

### 1. `wire`
- Represents a connection (a physical wire in hardware).
- Used for combinational logic where the value is continuously driven by an expression or another module.
- Cannot store values; it only passes signals.

#### Example:
```verilog
wire a, b, c;  // Declares wires a, b, and c
assign c = a & b;  // `c` is driven by the logical AND of `a` and `b`
```

### 2. `reg`
- Represents storage (e.g., a flip-flop or latch in hardware).
- Holds its value until explicitly assigned a new value.
- Commonly used in procedural blocks (`always`, `initial`).

#### Example:
```verilog
reg d;  // Declares a register `d`
initial begin
    d = 1;  // Assigns an initial value to `d`
end
```

---

## Verilog Operators
Operators in Verilog are used for arithmetic, logical, and bitwise operations.

### 1. Arithmetic Operators
- `+`: Addition
- `-`: Subtraction
- `*`: Multiplication
- `/`: Division
- `%`: Modulus (remainder)

#### Example:
```verilog
assign sum = a + b;  // Adds `a` and `b`
```

### 2. Logical Operators
- `&&`: Logical AND
- `||`: Logical OR
- `!`: Logical NOT

#### Example:
```verilog
assign result = a && b;  // Logical AND
```

### 3. Bitwise Operators
- `&`: Bitwise AND
- `|`: Bitwise OR
- `^`: Bitwise XOR
- `~`: Bitwise NOT

#### Example:
```verilog
assign result = a ^ b;  // Bitwise XOR
```

---

## Activity: Write a Verilog Module

### Objective
Create a module that demonstrates the use of `wire` and `reg` types, along with basic arithmetic and logical operations.

### Code:
```verilog
module data_types_example(
    input wire a,          // Input signal
    input wire b,          // Input signal
    output wire sum,       // Output for addition
    output wire logic_and, // Output for logical AND
    output reg result      // Register to store a calculated result
);

// Using `wire` for combinational logic
assign sum = a + b;           // Arithmetic operation
assign logic_and = a && b;    // Logical operation

// Using `reg` to store a result
always @(*) begin
    if (a && b)               // Logical AND condition
        result = a + b;       // Store addition result in `result`
    else
        result = 0;           // Default value
end

endmodule
```

### Explanation:
1. **Inputs and Outputs:**
   - `a` and `b` are inputs declared as `wire`.
   - `sum` and `logic_and` are outputs driven by combinational logic.
   - `result` is a `reg` type to store a calculated value.

2. **Assignments:**
   - `sum` computes the arithmetic addition of `a` and `b`.
   - `logic_and` performs a logical AND operation on `a` and `b`.

3. **Procedural Block:**
   - The `always` block updates the value of `result` based on a condition (`a && b`).
   - This demonstrates the use of `reg` to hold intermediate results.

---

## Task
1. Write your own Verilog module with:
   - Inputs: Two wires (`x` and `y`).
   - Outputs: The sum (`x + y`), the product (`x * y`), and the XOR (`x ^ y`).
   - A `reg` to store a conditional result (e.g., store the product only if `x` is greater than `y`).

2. Test the module with different input values.