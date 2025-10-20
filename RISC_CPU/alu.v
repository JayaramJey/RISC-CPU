module alu(
    input  [31:0] A, B,
    input  [3:0] ALU_Selection,
    output [31:0] ALU_Out,
    output        Zero
);
    reg [31:0] ALU_Result;
    assign ALU_Out = ALU_Result;
    assign Zero = (ALU_Result == 32'd0);

    always @(*) begin
        case(ALU_Selection)
            4'b0000: ALU_Result = A + B ; // ADD
            4'b0001: ALU_Result = A - B ; // SUB
            4'b0010: ALU_Result = A * B ; // MUL
            4'b0011: ALU_Result = A / B ; // DIV (simulation only; beware synthesis)
            4'b0100: ALU_Result = A & B ; // AND
            4'b0101: ALU_Result = A | B ; // OR
            default: ALU_Result = A + B;
        endcase
    end
endmodule

