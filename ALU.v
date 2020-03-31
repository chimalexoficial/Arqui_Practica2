module ALU 
(
	input [3:0] ALUOperation,
  	input [31:0] rs,
	input [31:0] A,
	input [31:0] B,
	input [4:0] shamt,
	output reg Zero,
	output reg isJR,
	output reg [31:0]ALUResult
);

localparam ADD 		= 4'b0000;
localparam SUB 		= 4'b0001;
localparam OR  		= 4'b0010;
localparam AND 		= 4'b0011;
localparam LUI 		= 4'b0100;
localparam NOR 		= 4'b0101;
localparam SLL 		= 4'b0110;
localparam SRL 		= 4'b0111;
localparam BRANCH 	= 4'b1000;
localparam JR 		= 4'b1001;


   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
		  ADD:
			ALUResult=A + B;
		  SUB:
			ALUResult=A - B;
		  OR:
			ALUResult=A | B;
		  AND:
			ALUResult=A & B;
		  LUI:
			ALUResult= {B[15:0], 16'h0000};
		  NOR:
			ALUResult=~(A|B);
		  SLL:
			ALUResult=A << shamt;
		  SRL:
			ALUResult=A >> shamt;
		  
		  BRANCH:
			ALUResult = rs - A;
		  JR:
			ALUResult= A;
		default:
			ALUResult= 0;
		endcase 
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
		ALUResult = (ALUOperation == BRANCH)? rs : ALUResult;
		isJR = (ALUOperation == JR) ? 1'b1 : 1'b0;
     end
endmodule