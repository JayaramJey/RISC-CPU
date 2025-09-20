module alu(
    	input  [31:0] A, B,              
    	input  [3:0] ALU_Selection,     
    	output [31:0] ALU_Out
	);
	reg [31:0] ALU_Result; 
	
	assign ALU_Out =  ALU_Result
	
	always @(*) begin
		case(ALU_Selection)
		4'b0000: // Addition
           		ALU_Result = A + B ; 
        	4'b0001: // Subtraction
           		ALU_Result = A - B ;
        	4'b0010: // Multiplication
          		 ALU_Result = A * B;
        	4'b0011: // Division
           		ALU_Result = A/B;
		4'b0100: // Logical and
           		ALU_Result = A & B;
         	4'b0101: // Logical or
           		ALU_Result = A | B;
		default: ALU_Result = A + B;
		endcase
	end
endmodule

