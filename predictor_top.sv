module predictor_top #(parameter M = 3, parameter K = 4, parameter N = 3) (
    input logic clk,
    input logic reset,
    input logic [K-1:0] index,
    input logic branch_outcome, // Actual outcome
    output logic prediction,     // Predicted outcome
    output logic success,
    output logic [6:0] seg,
    output logic [3:0] an
);
    logic [M-1:0] bhr_out;     // Output from BHR
    logic clk_out,disp_clk ;
    logic [15:0] count;
    logic [6:0] seg1,seg2,seg3,seg4;
    //Instantiate BHR
    clk_div #(50000000) ck1 (.clk(clk),.reset(reset),.clk_out(clk_out));
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

    clk_div #(833333) ck2 (.clk(clk),.reset(reset),.clk_out(disp_clk)); //60Hz clk
    miss_count misses(.clk(clk_out), .reset(reset), .clr(clr), .count(count));
    bcd_to_seg segm1(.binary_input(count[3:0]), .seg(seg1));
    seg_disp segment(.clk(disp_clk), .reset(reset), .seg_in_1(seg1),.seg(seg) ,.an(an));
    always_comb  begin
        if (prediction == branch_outcome)
        begin success = 1; end
        else begin
        success = 0;
        end
    end 
        
endmodule
