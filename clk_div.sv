module clk_div (
    input logic clk,reset,
    output logic clk_out
);

logic [31:0] count;
always_ff @( posedge clk ) begin : blockName
    if (reset)
    begin
        clk_out <= 0;
        count <= 0;
    end
    else
    begin
        count <= count +1;
        if (count == 25000000 -1)
        begin
            clk_out <= ~clk_out;
            count <= 0;
        end
        else
        begin
            clk_out <= clk_out;
        end
    end
end

    
endmodule