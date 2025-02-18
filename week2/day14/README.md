# Day 14: Understanding Finite State Machines (FSMs)

Finite State Machines (FSMs) are fundamental in digital design for modeling sequential logic. FSMs help in designing control logic for circuits like traffic light controllers, vending machines, and processors.

---

## 1. What are Finite State Machines?
An FSM is a mathematical model of computation consisting of:
- **States**: Represent different conditions of the system.
- **Transitions**: Define movement between states based on inputs.
- **Inputs and Outputs**: Govern how transitions occur and what outputs are produced.

There are two main types of FSMs:
1. **Moore Machine**: Outputs depend only on the current state.
2. **Mealy Machine**: Outputs depend on both the current state and inputs.

---

## 2. Mealy vs. Moore Machines

| Feature         | Mealy Machine | Moore Machine |
|----------------|--------------|--------------|
| Output Depends On | Current state & Inputs | Only the Current State |
| Reactivity | Faster (output changes with input) | Slower (output changes at state transitions) |
| Complexity | Typically requires fewer states | More states may be needed |

---

## 3. FSM Design in Verilog
FSMs in Verilog are typically implemented using three blocks:
1. **State Register**: Holds the current state.
2. **Next-State Logic**: Determines the next state based on inputs.
3. **Output Logic**: Computes output based on the current state (Moore) or state and input (Mealy).

### Example: Moore Machine (Simple Traffic Light Controller)
```verilog
module traffic_light(
    input clk,
    input reset,
    output reg [1:0] light // 00 = Red, 01 = Green, 10 = Yellow
);
    typedef enum reg [1:0] {RED, GREEN, YELLOW} state_t;
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= RED;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            RED:    next_state = GREEN;
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end
    
    always @(*) begin
        case (state)
            RED:    light = 2'b00;
            GREEN:  light = 2'b01;
            YELLOW: light = 2'b10;
            default: light = 2'b00;
        endcase
    end
endmodule
```

### Example: Mealy Machine (Sequence Detector for "101")
```verilog
module seq_detector(
    input clk,
    input reset,
    input in,
    output reg out
);
    typedef enum reg [1:0] {S0, S1, S2} state_t;
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S1 : S2;
            S2: next_state = (in) ? S0 : S0;
            default: next_state = S0;
        endcase
    end
    
    always @(*) begin
        out = (state == S2 && in) ? 1'b1 : 1'b0;
    end
endmodule
```

---

## 4. Activity: Sketch State Diagrams
### Task:
- Draw state diagrams for a simple **traffic light controller** (Moore FSM).
- Design a **sequence detector** FSM for detecting "1101" (Mealy FSM).

### Steps:
1. Identify the states required.
2. Define state transitions based on input conditions.
3. Label outputs accordingly.
4. Verify the logic before implementing it in Verilog.

---

## Summary
- FSMs model sequential logic with defined states and transitions.
- Moore machines depend only on the state, while Mealy machines depend on state and inputs.
- FSMs can be efficiently implemented in Verilog using **state registers, next-state logic, and output logic**.

### Next Step:
Try implementing your own FSM in Verilog and simulate it using a testbench!

🚀 **Happy Coding!**

