module register_file (
    input clk,
    input load_enable,
    // holds the register number from 0 - 31
    input [4:0] ra, rb, rc,
    // data that is being written
    input [31:0] ry,
    // Data from the selected registers goes into these
    output [31:0] rd1, rd2
);
    // 32 registers
    reg [31:0] regs [31:0];

    // initialize registers to 0 for simulation/demo
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'd0;
        // set a couple of non-zero regs to use for waveforms
        regs[1] = 32'd10;   // x1 = 10
    	regs[2] = 32'd4;    // x2 = 4
    	regs[5] = 32'd7;    // x5 = 7
    end

    // asynchronous read
    assign rd1 = regs[ra];
    assign rd2 = regs[rb];

    always @(posedge clk) begin
        if (load_enable) begin
            // do not allow writing register 0 (x0 always zero)
            if (rc != 5'd0)
                regs[rc] <= ry;
        end
    end
endmodule

