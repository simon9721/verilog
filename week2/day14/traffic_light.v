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