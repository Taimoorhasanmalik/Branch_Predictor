module predictor_tb;


    logic clk, reset, branch_outcome, prediction;

    predictor_top dut(.clk(clk), .reset(reset), .branch_outcome(branch_outcome), .prediction(prediction));

    initial begin
        clk = 0;#5;
        forever begin
            clk = ~clk;#5;
        end
    end
    initial begin
        reset = 0;#5;
        reset = 1;#10;
        reset = 0;#10;
        branch_outcome = 0;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 1;#5;
        branch_outcome = 0;#5;
        branch_outcome = 0;#5;
        branch_outcome = 0;#5;
        branch_outcome = 0;#5;
        $stop;
    end
    
endmodule