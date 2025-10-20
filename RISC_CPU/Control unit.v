module control_unit(
    input  [5:0] opcode,          // instr[31:26]  main instruction type
    input  [5:0] funct,           // instr[5:0] used for R-type to select ALU operation
    output reg RegWrite,          // enables writing to the register file
    output reg ALUSrc,            // selects ALU input B: 0 = register, 1 = immediate
    output reg MemRead,           // enables reading from data memory (ldw instructions)
    output reg MemWrite,          // enables writing to data memory (write instructions
    output reg [3:0] ALU_Selection, // selects the operation for the ALU
    output reg [1:0] PC_Select,     // selects how PC updates: increment, branch, jump, hold
);

always @(*) begin
    // Set default safe values for all control signals
    RegWrite      = 0;
    ALUSrc        = 0;
    MemRead       = 0;
    MemWrite      = 0;
    ALU_Selection = 4'b0000;  // default to ADD
    PC_Select     = 2'b00;    // default increment
   
    // Determine control signals based on opcode
    case(opcode)
        6'b000000: begin  // R-type instruction
            RegWrite = 1;
            ALUSrc   = 0;

            case(funct)
                6'b100000: ALU_Selection = 4'b0000; // ADD
                6'b100010: ALU_Selection = 4'b0001; // SUB
                6'b100100: ALU_Selection = 4'b0100; // AND
                6'b100101: ALU_Selection = 4'b0101; // OR
                6'b011000: ALU_Selection = 4'b0010; // MUL
                6'b011010: ALU_Selection = 4'b0011; // DIV
                default:   ALU_Selection = 4'b0000; // default ADD
            endcase
        end
	6'b001000: begin // ADDI opcode
    	     RegWrite = 1;      // write result back to rd
    	     ALUSrc   = 1;      // use immediate instead of rd2
    	     ALU_Selection = 4'b0000; // ADD
	end
    endcase
end

endmodule

