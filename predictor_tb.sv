module predictor_tb;


    logic clk, reset, branch_outcome, prediction;
    logic [4-1:0] index;
    predictor_top dut(.clk(clk), .reset(reset), .branch_outcome(branch_outcome), .prediction(prediction) ,.index(index) ,.success(success));

    initial begin
        clk = 0;#5;
        forever begin
            clk = ~clk;#5;
        end
    end
    initial begin
        reset = 0;#10;
        reset = 1;#50;
        reset = 0;#10;
    end
    always@(posedge clk)begin
        if (reset)
        begin
            index <= 0;
            branch_outcome <= 0;
        end
        else begin
            index <= index +1;branch_outcome <= branch_outcome+1;
        end
        end
endmodule