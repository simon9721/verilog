module sequence_detector (
    input wire clk,
    input wire rst,
    input wire in,
    output reg detected
);

    typedef enum reg [2:0] {S0, S1, S2, S3, S4} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end
// detect a 1101 sequence
    always @(*) begin
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S2 : S3;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        detected = (state == S3 && in);
    end

endmodule