module branch_history_register #(parameter M = 4) (
    input logic clk,
    input logic reset,
    input logic branch_outcome,  // 1: taken, 0: not taken
    output logic [M-1:0] bhr_out // Current branch history
);
    logic [M-1:0] bhr;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            bhr <= '0; // Clear BHR on reset
        else 
            bhr <= {bhr[M-1:1], branch_outcome}; // Shift in new outcome
    end

    assign bhr_out = bhr;
endmodule
