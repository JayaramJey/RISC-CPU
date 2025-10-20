`timescale 1ns/1ps

module cpu(
    input clk,
    input reset
);

    // Wires between modules
    wire [31:0] pc_out;           // current PC
    wire [31:0] instr;            // instruction from memory
    wire [31:0] instr_reg_out;    // latched instruction
    wire [3:0] ALU_Selection;     // control signal to ALU
    wire [1:0] PC_Select;         // always increment
    wire RegWrite;                // enable register write
    wire ALUSrc;                  // choose ALU input B: 0=reg,1=immediate
    wire MemRead, MemWrite;       // memory signals

    // Register file wires
    wire [31:0] rd1, rd2;         // outputs from register file
    wire [31:0] alu_input_b;      // second ALU input (first is always a register but second could be register or immediate value)
    wire [31:0] alu_out;          // ALU result

    // Sign-extended immediate for immidiate value operations
    wire [31:0] imm_ext = {{16{instr_reg_out[15]}}, instr_reg_out[15:0]};

    // Instruction Memory
    instr_mem IM (
        .addr(pc_out),
        .instr(instr)
    );


    // Instruction Register
    instr_register IR (
        .clk(clk),
        .reset(reset),
        .instr_in(instr),
        .instr_out(instr_reg_out)
    );

    // Control Unit (branch-free)
    control_unit CU (
        .opcode(instr_reg_out[31:26]),
        .funct(instr_reg_out[5:0]),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALU_Selection(ALU_Selection),
        .PC_Select(PC_Select) // always increment
    );

    // Register File
    register_file RF (
        .clk(clk),
        .load_enable(RegWrite),
        .ra(instr_reg_out[25:21]),    // rs
        .rb(instr_reg_out[20:16]),    // rt
        .rc(instr_reg_out[15:11]),    // rd
        .ry(alu_out),                  // ALU output written back
        .rd1(rd1),
        .rd2(rd2)
    );


    // ALU
    assign alu_input_b = ALUSrc ? imm_ext : rd2;

    alu ALU (
        .A(rd1),
        .B(alu_input_b),
        .ALU_Selection(ALU_Selection),
        .ALU_Out(alu_out)
    );

  
    // PC Module (branch-free)
    pc_module PC (
        .clk(clk),
        .reset(reset),
        .PC_Select(2'b00),       // always increment
        .Branch_Address(32'd0),  // not used
        .Jump_Address(32'd0),    // not used
        .PC_Out(pc_out)
    );

endmodule

