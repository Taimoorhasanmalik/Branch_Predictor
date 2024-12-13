module seg_disp (
    input logic clk,reset,
    input logic [6:0] seg_in_1,
    output logic [6:0] seg,
    output logic [3:0] an
);


always @( posedge clk, posedge reset ) begin
    if (reset)
    begin
        seg <= 7'b1111111;
        an <= 4'b1111;
    end
    else
    begin
        an <= 4'b1110;
        
    end
end

    
endmodule