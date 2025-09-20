module instruction_register (
    input clk,
    input reset,
    input IR_Write,                 // control: 1=load new instruction, 0=hold
    input [31:0] Instruction_In,   // instruction from memory
    output reg [31:0] Instruction_Out // current instruction
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            Instruction_Out <= 32'd0;    // clear instruction on reset
        else if (IR_Write)
            Instruction_Out <= Instruction_In; // new instruction
        else
            Instruction_Out <= Instruction_Out; // hold value
    end

endmodule