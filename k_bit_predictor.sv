module k_bit_predictor #(parameter K = 4,
                        parameter N = 2) (
    input logic clk,
    input logic reset,
    input logic [K-1:0] index, // BHR used to index the table
    input logic branch_outcome,       // Actual branch outcome
    output logic prediction           // 1: taken, 0: not taken
);
    logic [N-1:0] pht[(1<<K)-1:0]; // N-bit counters

    // Predict based on the current counter value
    assign prediction = pht[index][1]; // MSB of the counter

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < (1<<K); i++)
                pht[i] <= 0; // Initialize counters to not taken
        end
        else begin
            if (branch_outcome) begin
                // Increment counter
                if (pht[index] + 1 != 0)
                    pht[index] <= pht[index] + 1;
            end
            else begin
                // Decrement counter
                if (pht[index] > 0)
                    pht[index] <= pht[index] - 1;
            end
        end
    end
endmodule
