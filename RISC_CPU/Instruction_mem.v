module instr_mem(
    input  [31:0] addr,       // Address from PC
    output [31:0] instr       // Instruction output
);
    // 256-word instruction memory (32 bits each)
    reg [31:0] memory [0:255];

    initial begin
        // Example program (replace with your instructions)
        memory[0] = 32'h00221820; // add rd, rt, rs
        memory[1] = 32'h8C220000; // ldw  rd, 0(rs)
        memory[2] = 32'hAC230000; // stw  rd, 0(rs)
        memory[3] = 32'h10620004; // beq rs, rt, 4(memory location 0x0004)
    end

    // Word-aligned addressing: ignore lowest 2 bits
    assign instr = memory[addr[9:2]];
endmodule

