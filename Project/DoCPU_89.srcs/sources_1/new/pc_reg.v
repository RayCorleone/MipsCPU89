`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    ָ��ָ��Ĵ���PC
// Vision   0.0
// Auther   Ray
//////////////////////////////////////////////////////////////////////////////////

module pc_reg(

	input wire clk,
	input wire rst,

	//���Կ���ģ�����Ϣ
	input wire[5:0]               stall,
	input wire                    flush,
	input wire[`RegBus]           new_pc,

	//��������׶ε���Ϣ
	input wire                    branch_flag_i,
	input wire[`RegBus]           branch_target_address_i,
	
	output reg[`InstAddrBus] pc,
	output reg               ce
	
);

	// always @ (posedge clk or posedge rst) begin
	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
		// if (rst == `RstEnable) begin
			pc <= `TextBegin;
		end else if (ce != `ChipDisable) begin
			if(flush == 1'b1) begin
				pc <= new_pc;
			end else if(stall[0] == `NoStop) begin
				if(branch_flag_i == `Branch) begin
					pc <= branch_target_address_i;
				end else begin
		  		pc <= pc + 4'h4;
		  	end
			end
		end
	end

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;
		end
	end

endmodule