module miss_count (
    input logic clk, reset, success, clr,
    output logic [15:0] count 
);

always_ff @( posedge clk , posedge reset ) begin 
    if (reset)
    begin
        count <= 0;
    end
    else 
    begin
        if (clr)
        begin
            count <= 0;
        end
        else
        begin
            if (~success) begin
            count <= count +1;
            end
            else begin
                count <= count;
            end
        end
    end
end
    
endmodule