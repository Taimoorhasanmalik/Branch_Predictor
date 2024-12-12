module mnk_bit_predictor #(parameter K = 4,
                        parameter N = 2,
                        parameter M = 4
                        ) (
    input logic clk,
    input logic reset,
    input logic [K-1:0] index,
    input logic [M-1:0] bhr_in,
    input logic branch_outcome,       // Actual branch outcome
    output logic prediction           // 1: taken, 0: not taken
);
    logic [N-1:0] pht [((1<<K)*(1<<M))-1:0]; // N-bit 2^K counters
    logic [K + M -1:0] new_index;
    // Predict based on the current counter value
    assign new_index = {bhr_in,index};

    always_ff @(posedge clk , posedge reset) begin
        if (reset) begin
            for (int i = 0; i < (1<<K)*(1<<M); i++)
                pht[i] <= 0; // Initialize counters to not taken
        end
        else begin
            prediction <= pht[new_index][N-1];
            if (branch_outcome) begin
                // Increment counter
                if (pht[new_index] + 1 != 0)
                    pht[new_index] <= pht[new_index] + 1;
            end
            else begin
                // Decrement counter
                if (pht[new_index] > 0)
                    pht[new_index] <= pht[new_index] - 1;
            end
        end
    end
endmodule
