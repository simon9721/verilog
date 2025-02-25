module debounce (
    input wire clk,         // System clock
    input wire rst,         // Reset signal
    input wire noisy_in,    // Noisy switch input
    output reg clean_out    // Debounced output
);

    parameter COUNTER_MAX = 4; // Adjust based on clock frequency
    reg [16:0] counter; // Counter register
    reg stable_state; // Tracks last stable state

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            stable_state <= 0;
            clean_out <= 0;
        end else begin
            if (noisy_in == stable_state) begin
                counter <= 0; // Reset counter if input remains the same
            end else begin
                counter <= counter + 1;
                if (counter >= COUNTER_MAX) begin
                    stable_state <= noisy_in;
                    clean_out <= noisy_in;
                    counter <= 0;
                end
            end
        end
    end
endmodule