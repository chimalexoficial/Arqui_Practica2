module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 128
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
assign  PortOut = 0;

wire branch_ne_wire;
wire branch_eq_wire;
wire reg_dst_wire;
wire not_zero_and_brach_ne;
wire zero_and_brach_eq;
wire or_for_branch;
wire alu_src_wire;
wire reg_write_wire;
wire zero_wire;
wire [3:0] aluop_wire;
wire [3:0] alu_operation_wire;
wire [4:0] write_register_wire;

wire [31:0] instruction_bus_wire;
wire [31:0] read_data_1_wire;
wire [31:0] read_data_2_wire;
wire [31:0] Inmmediate_extend_wire;
wire [31:0] read_data_2_orr_inmmediate_wire;
wire [31:0] alu_result_wire;
wire [31:0] pc_plus_4_wire;
wire [31:0] inmmediate_extended_wire;
wire [31:0] pc_to_branch_wire;
wire [31:0] MUX_PC_wire;
wire [31:0] pc_wire;

wire MemWriteControl;
wire MemReadControl;
wire MemtoRegControl;

wire [31:0]  ReadDataDataMemory;
wire [31:0] MuxAluRam;
wire [31:0] MuxAluPc;
wire [31:0] MUX_PC_wire_Jump;
wire [31:0] MUX_PC_wire_Write;

wire jr_wire;
wire jump_wire;
wire jal_wire;
wire PCSrc;

wire [4:0] write_register_wire2;
wire [31:0] Inmmediate_extend_SL2_wire;
wire [31:0] jumpAddress;
wire [31:0] jumpAddressAux;

Control
ControlUnit
(
	.OP(instruction_bus_wire[31:26]),
	.RegDst(reg_dst_wire),
	.BranchNE(branch_ne_wire),
	.BranchEQ(branch_eq_wire),
	.ALUOp(aluop_wire),
	.ALUSrc(alu_src_wire),
	.RegWrite(reg_write_wire),
	.MemRead(MemReadControl),
	.MemWrite(MemWriteControl),
	.MemtoReg(MemtoRegControl),
	.Jump(jump_wire),
	.Jal(jal_wire)
);

ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(pc_wire),
	.Instruction(instruction_bus_wire)
);

Adder32bits
PC_Puls_4
(
	.Data0(pc_wire),
	.Data1(4),
	
	.Result(pc_plus_4_wire)
);

DataMemory
#( 	.DATA_WIDTH(),
	.MEMORY_DEPTH()
)
RamMemory
(	.WriteData(read_data_2_wire),
	.Address(alu_result_wire),
	.MemWrite(MemWriteControl),
	.MemRead(MemReadControl),
	.clk(clk),
	.ReadData(ReadDataDataMemory)
);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(reg_dst_wire),
	.MUX_Data0(instruction_bus_wire[20:16]),
	.MUX_Data1(instruction_bus_wire[15:11]),
	
	.MUX_Output(write_register_wire2)

);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_JAL 
(	
	.Selector(jal_wire),
	.MUX_Data0(write_register_wire2),
	.MUX_Data1(5'b11111),
	
	.MUX_Output(write_register_wire)
);


Multiplexer2to1
#(
	.NBits()
)
MUX_ALU_RAM
(
	.Selector(MemtoRegControl),
	.MUX_Data0(alu_result_wire),
	.MUX_Data1(ReadDataDataMemory),
	
	.MUX_Output(MuxAluRam)
);

Multiplexer2to1
#(	
	.NBits(32)
)
MUX_ALU_PC 
(
	.Selector(jal_wire),
	.MUX_Data0(MuxAluRam),
	.MUX_Data1(pc_plus_4_wire),
	
  .MUX_Output(MuxAluPc)

);

RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(reg_write_wire),
	.WriteRegister(write_register_wire),
	.ReadRegister1(instruction_bus_wire[25:21]),
	.ReadRegister2(instruction_bus_wire[20:16]),
	.WriteData(MuxAluPc),
	.ReadData1(read_data_1_wire),
	.ReadData2(read_data_2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(instruction_bus_wire[15:0]),
   .SignExtendOutput(Inmmediate_extend_wire)
);



Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(alu_src_wire),
	.MUX_Data0(read_data_2_wire),
	.MUX_Data1(Inmmediate_extend_wire),
	
	.MUX_Output(read_data_2_orr_inmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(aluop_wire),
	.ALUFunction(instruction_bus_wire[5:0]),
	.ALUOperation(alu_operation_wire)

);



ALU
ArithmeticLogicUnit 
(
	.ALUOperation(alu_operation_wire),
	.A(read_data_1_wire),
	.B(read_data_2_orr_inmmediate_wire),
	.Zero(zero_wire),
	.ALUResult(alu_result_wire),
	.rs(read_data_2_wire),
	.shamt(instruction_bus_wire[10:6]),
	.isJR(jr_wire)
	
);

PC_Register
#(
 .N(32)
)
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(MUX_PC_wire_Write),
	.PCValue(pc_wire)
);

ANDGate
ZeroAndBranchEQ_AND
(
	.A(branch_eq_wire),
	.B(zero_wire),
	.C(zero_and_brach_eq)
);

ANDGate
NotZeroAndBranchNE_AND
(
	.A(branch_ne_wire),
	.B(~zero_wire),
	.C(not_zero_and_brach_ne)
);

ORGate
ORGate_BranchNE_BranchEQ
(
	.A(zero_and_brach_eq),
	.B(not_zero_and_brach_ne),
	.C(PCSrc)
);


ShiftLeft2 
SL2_Extend
(
	.DataInput(Inmmediate_extend_wire),
	.DataOutput(Inmmediate_extend_SL2_wire)
);

Adder32bits 
PC4_Adder
(
	.Data0(pc_plus_4_wire),
	.Data1(Inmmediate_extend_SL2_wire),
	.Result(inmmediate_extended_wire)
);

Multiplexer2to1 
#(
	.NBits(32)
)
Mux_PC4Wire_ImmediateExtendedAndedWire
(
	.Selector(PCSrc),
	.MUX_Data0(pc_plus_4_wire),
	.MUX_Data1(inmmediate_extended_wire),
	
	.MUX_Output(MUX_PC_wire)

);


ShiftLeft2 
SL2_Jump
(
	.DataInput({6'b0, instruction_bus_wire[25:0]}),
	.DataOutput(jumpAddressAux)
);

Adder32bits 
Address_Jump
(
	.Data0({pc_plus_4_wire[31:28], 28'b0}),
	.Data1(jumpAddressAux),
	.Result(jumpAddress)
);


Multiplexer2to1 
#(
	.NBits(32)
)
MUX_MuxPCWire_JumpAddress
(
	.Selector(jump_wire),
	.MUX_Data0(MUX_PC_wire),
	.MUX_Data1(jumpAddress - 4194304),
	
	.MUX_Output(MUX_PC_wire_Jump)

);

Multiplexer2to1  
#(	
	.NBits(32)
)
MUX_SuperMUXPC_JR_PC8
(
	.Selector(jr_wire),
	.MUX_Data0(MUX_PC_wire_Jump),
	.MUX_Data1(MuxAluRam), 
	
	.MUX_Output(MUX_PC_wire_Write)

);

assign ALUResultOut = alu_result_wire;


endmodule

