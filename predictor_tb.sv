module predictor_tb;


    logic clk, reset, branch_outcome, prediction;
    integer i;
    logic [4-1:0] index;
    predictor_top dut(.clk(clk), .reset(reset), .branch_outcome(branch_outcome), .prediction(prediction) ,.index(index) ,.success(success));

    initial begin
        clk = 0;#5;
        forever begin
            clk = ~clk;#5;
        end
    end
    initial begin
        branch_outcome = 0;#10;
        reset = 0;#10;
        reset = 1;#50;
        reset = 0;#10;
        for (i = 0; i < 10000 ; i++ ) begin
            index = 4'b0011;branch_outcome = ~branch_outcome;#15;
            index = 4'b0100;branch_outcome = 1;#15;
        end
        $stop;
    end
endmodule