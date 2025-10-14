module control_unit(
    input  [5:0] opcode,          // instr[31:26] ? main instruction type
    input  [5:0] funct,           // instr[5:0] ? used for R-type to select ALU operation
    output reg RegWrite,          // enables writing to the register file
    output reg ALUSrc,            // selects ALU input B: 0 = register, 1 = immediate
    output reg MemRead,           // enables reading from data memory
    output reg MemWrite,          // enables writing to data memory
    output reg [3:0] ALU_Selection, // selects the operation for the ALU
    output reg [1:0] PC_Select       // selects how PC updates: increment, branch, jump, hold
);

always @(*) begin
    // set default safe values for all control signals
    RegWrite      = 0;
    ALUSrc        = 0;
    MemRead       = 0;
    MemWrite      = 0;
    ALU_Selection = 4'b0000;  // default to ADD
    PC_Select     = 2'b00;    // default increment

    // determine control signals based on opcode
    case(opcode)
        6'b000000: begin  // Register type instruction
            RegWrite = 1; // write result to register
            ALUSrc   = 0; // second ALU input comes from register

            // use funct field to select specific ALU operation
            case(funct)
                6'b100000: ALU_Selection = 4'b0000; // ADD
                6'b100010: ALU_Selection = 4'b0001; // SUB
                6'b100100: ALU_Selection = 4'b0100; // AND
                6'b100101: ALU_Selection = 4'b0101; // OR
                6'b011000: ALU_Selection = 4'b0010; // MUL
                6'b011010: ALU_Selection = 4'b0011; // DIV
                default:   ALU_Selection = 4'b0000; // default to ADD
            endcase
        end
        6'b100011: begin  // load word
            RegWrite      = 1; // write loaded data to register
            ALUSrc        = 1; // second ALU input comes from immediate offset
            MemRead       = 1; // enable memory read
            ALU_Selection = 4'b0000; // ALU adds base + offset
        end
        6'b101011: begin  // store word
            ALUSrc        = 1; // second ALU input comes from immediate offset
            MemWrite      = 1; // enable memory write
            ALU_Selection = 4'b0000; // ALU adds base + offset
        end
        6'b000100: begin  // beq ? branch if equal
            ALUSrc        = 0; // second ALU input comes from register
            ALU_Selection = 4'b0001; // ALU subtracts to compare
            PC_Select     = 2'b01;   // select branch address
        end
        6'b000010: begin  // jump instruction
            PC_Select     = 2'b10;   // select jump address
        end
    endcase
end

endmodule

