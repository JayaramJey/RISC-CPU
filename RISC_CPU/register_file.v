module register_file (
	input clk,
	input load_enable,
	// holds the register number from 0 - 31
	input [4:0] ra, rb, rc,
	// data that is being written
	input [31:0] ry
	// Data from the selected regsiters goes into these
	output [31:0] rd1, rd2
);
	//registers 
	reg [31:0] regs [31:0];
	// assign the values from registers ra and rb to rd1 and rd2 
	assign rd1 = regs[ra];
	assign rd2 = regs[rb];
	
	always @(posedge clk) begin
		if (load_enable) begin
			regs[rc] <= ry;
		end
	end
endmodule	
