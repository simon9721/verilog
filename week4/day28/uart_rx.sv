module uart_rx (
    input logic clk, rst, rx,
    output logic [7:0] data_out,
    output logic valid
);
    typedef enum logic [2:0] {IDLE, START, DATA, PARITY, STOP} state_t;
    state_t state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;
    logic parity_bit;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            valid <= 0;
            bit_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (!rx) begin // Detect start bit
                        state <= START;
                        bit_count <= 0;
                    end
                end
                START: begin
                    state <= DATA;
                end
                DATA: begin
                    shift_reg <= {rx, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) state <= PARITY;
                end
                PARITY: begin
                    parity_bit <= ^shift_reg; // Calculate received parity
                    state <= STOP;
                end
                STOP: begin
                    if (rx) begin // Verify stop bit
                        data_out <= shift_reg;
                        valid <= 1;
                    end
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule