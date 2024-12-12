module predictor_top #(parameter M = 4, parameter K = 4, parameter N = 2) (
    input logic clk,
    input logic reset,
    input logic branch_outcome, // Actual outcome
    output logic prediction     // Predicted outcome
);
    logic [M-1:0] bhr_out;     // Output from BHR
    logic [K-1:0] index; // Index to PHT

    // Instantiate BHR
    branch_history_register #(M) bhr_inst (
        .clk(clk),
        .reset(reset),
        .branch_outcome(branch_outcome),
        .bhr_out(bhr_out)
    );

    // Map BHR output to PHT index
    assign index = bhr_out[K-1:0]; // Take lower bits of BHR for indexing

    // Instantiate PHT
    k_bit_predictor #(K, N) pht_inst (
        .clk(clk),
        .reset(reset),
        .index(index),
        .branch_outcome(branch_outcome),
        .prediction(prediction)
    );

endmodule
