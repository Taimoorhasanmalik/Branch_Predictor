module predictor_top #(parameter M = 3, parameter K = 4, parameter N = 3) (
    input logic clk,
    input logic reset,
    input logic [K-1:0] index,
    input logic branch_outcome, // Actual outcome
    output logic prediction,     // Predicted outcome
    output logic success
);
    logic [M-1:0] bhr_out;     // Output from BHR
    logic clk_out ;
    //Instantiate BHR
    clk_div ck(.clk(clk),.reset(reset),.clk_out(clk_out));
    branch_history_register #(M) bhr_inst (
        .clk(clk_out),
        .reset(reset),
        .branch_outcome(branch_outcome),
        .bhr_out(bhr_out)
    );

    
    // Instantiate PHT
    mnk_bit_predictor #(K, N, M) pht_inst (
        .clk(clk_out),
        .reset(reset),
        .index(index),
        .bhr_in (bhr_out),
        .branch_outcome(branch_outcome),
        .prediction(prediction)
    );
    always_comb  begin
        if (prediction == branch_outcome)
        begin success = 1; end
        else begin
        success = 0;
        end
    end 
        
endmodule
