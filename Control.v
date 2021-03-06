module Control
(
	input [5:0]OP,
	
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output Jump,
	output Jal,
  	output [3:0]ALUOp

);

localparam R_Type = 0;
localparam I_Type_ADDI = 6'h08;
localparam I_Type_ORI =  6'h0d;
localparam I_Type_ANDI = 6'h0c;
localparam I_Type_LUI =  6'h0f;

localparam I_Type_SW =  6'h2b;
localparam I_Type_LW =  6'h23;

localparam I_Type_BEQ =  6'h04;
localparam I_Type_BNE =  6'h05;
localparam J_Type_JUMP=  6'h02;
localparam J_Type_JAL =  6'h03;

  reg [13:0] ControlValues;

always@(OP) begin
	casex(OP)
		R_Type:       	ControlValues= 14'b001_001_00_00_1111; 
		I_Type_ADDI:  	ControlValues= 14'b000_101_00_00_1000;
		I_Type_ORI:	ControlValues= 14'b000_101_00_00_1010;
		I_Type_ANDI:  	ControlValues= 14'b000_101_00_00_1100;
		I_Type_LUI:	ControlValues= 14'b000_101_00_00_0010;
		I_Type_LW:	ControlValues= 14'b000_111_10_00_1110;
		I_Type_SW:	ControlValues= 14'b000_100_01_00_0110;	
		I_Type_BEQ:	ControlValues= 14'b000_101_00_01_0100; 
		I_Type_BNE:	ControlValues= 14'b000_101_00_10_0111;
		J_Type_JUMP:  	ControlValues= 14'b010_000_00_00_0000;
		J_Type_JAL:   	ControlValues= 14'b111_101_00_00_0000; 
											  
		default:
			ControlValues= 14'b000_000_00_00_0000;
		endcase
end	
  assign ALUOp 		= ControlValues[3:0];
  assign BranchEQ 	= ControlValues[4];
  assign BranchNE 	= ControlValues[5];
  assign MemWrite 	= ControlValues[6];
  assign MemRead 	= ControlValues[7];
  assign RegWrite 	= ControlValues[8];
  assign MemtoReg 	= ControlValues[9];
  assign ALUSrc 	= ControlValues[10];
  assign RegDst 	= ControlValues[11];
  assign Jump 		= ControlValues[12];
  assign Jal 		= ControlValues[13];

endmodule