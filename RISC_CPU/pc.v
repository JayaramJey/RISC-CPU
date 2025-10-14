module pc_module (
	input clk,
    input reset,
    input [1:0] PC_Select,        //Select: 00=Increment, 01=Branch, 10=Jump, 11=Hold
    input [31:0] Branch_Address,    
    input [31:0] Jump_Address,
    output reg [31:0] PC_Out
);

    reg [31:0] PC_Next;

    //Update on clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC_Out <= 32'd0;    //PC becomes 0
        else 
            PC_Out <= PC_Next;    //Next PC Value
    end

    always @(*)begin
        case (PC_Select)
            2'b00: PC_Next = PC_Out + 32'd4;
            2'b01: PC_Next = Branch_Address;
            2'b10: PC_Next = Jump_Address;
            2'b11: PC_Next = PC_Out;
            default: PC_Next = PC_Out + 32'd4;
        endcase
    end
endmodule 