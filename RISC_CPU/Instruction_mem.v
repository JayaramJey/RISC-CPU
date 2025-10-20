module instr_mem(
    input  [31:0] addr,       // Address from PC
    output [31:0] instr       // Instruction output
);
    // 256-word instruction memory (32 bits each)
    reg [31:0] memory [0:255];

    initial begin
       
        memory[0] = 32'h00221820; // add rd, rt, rs
        memory[1] = 32'h00222022; // sub x4, x1, x2
        memory[2] = 32'h00221818; // mul x3, x1, x2
    end

    //address is given in byte addressing so change it to words and ignore the other bits since memory is smaller
    assign instr = memory[addr[9:2]];
endmodule

