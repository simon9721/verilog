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