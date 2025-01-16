# Day 1: Verilog Syntax Basics

## What is Verilog?
Verilog is a hardware description language (HDL) used to model and simulate digital circuits. Think of it as programming for hardware design, where the focus is on describing hardware behavior.

---

## 1. The Basic Structure of a Verilog Module
A **module** is the building block in Verilog. It describes a specific part of the hardware, such as a logic gate, a flip-flop, or even an entire processor.

### Skeleton of a Verilog Module:
```verilog
module <module_name> (port_list);
    // Internal declarations and logic here
endmodule
```

### Key Components:
1. **`module`**: Keyword to define the start of the module.
2. **`<module_name>`**: Name of the module (e.g., `basic_module`).
3. **`port_list`**: A list of input/output ports that connect the module to the external world.
4. **`endmodule`**: Marks the end of the module.

---

## 2. Declaring Ports
Ports are the connections between your module and the outside world.

### Types of Ports:
- **Inputs**: Signals coming into the module.
- **Outputs**: Signals going out of the module.

### Syntax:
```verilog
input <port_name>;
output <port_name>;
```

#### Example:
```verilog
module simple_module (
    input a,
    input b,
    output sum
);
endmodule
```

---

## 3. Adding Functionality
Inside the module, you define the logic or behavior. This is done using **assignments** or more complex constructs.

### Example: XOR Gate
Here’s a simple module that computes the XOR of two inputs:

```verilog
module xor_gate (
    input wire a,        // Input 1
    input wire b,        // Input 2
    output wire sum      // Output
);

assign sum = a ^ b;     // XOR operation

endmodule
```

### Explanation:
- `assign`: Used to define combinational logic.
- `^`: XOR operator in Verilog.

---

## 4. Your Task
Let’s practice by writing your own module!

### Objective
Create a module named `basic_module` with:
- Two inputs: `a` and `b`
- One output: `sum`
- Logic: Perform XOR operation between `a` and `b`

### Steps:
1. Use `module` and `endmodule`.
2. Declare the ports (`input`, `output`).
3. Use `assign` for the XOR logic.

---