module uart_tx (
    input logic clk, rst, start,
    input logic [7:0] data_in,
    output logic tx,
    output logic busy
);
    typedef enum logic [2:0] {IDLE, START, DATA, PARITY, STOP} state_t;
    state_t state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;
    logic parity_bit;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            busy <= 0;
            bit_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        shift_reg <= data_in;
                        parity_bit <= ^data_in; // Even parity
                        tx <= 0; // Start bit
                        busy <= 1;
                        state <= START;
                    end
                end
                START: begin
                    state <= DATA;
                    bit_count <= 0;
                end
                DATA: begin
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) state <= PARITY;
                end
                PARITY: begin
                    tx <= parity_bit;
                    state <= STOP;
                end
                STOP: begin
                    tx <= 1; // Stop bit
                    busy <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule