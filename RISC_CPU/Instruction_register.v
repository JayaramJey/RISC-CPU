module instr_register(
    input clk,                  // clock
    input reset,                // reset
    input [31:0] instr_in,      // instruction from memory
    output reg [31:0] instr_out // latched instruction for CPU
);

always @(posedge clk or posedge reset) begin
    if (reset)
        instr_out <= 32'b0;     // reset instruction to 0
    else
        instr_out <= instr_in;  // latch instruction on rising edge
end

endmodule

