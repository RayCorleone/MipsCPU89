`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    控制模块，控制流水线的刷新、暂停等
// Vision   0.0
// Auther   Ray
//////////////////////////////////////////////////////////////////////////////////

module ctrl(

	input wire										rst,

	input wire[31:0]             excepttype_i,
	input wire[`RegBus]          cp0_epc_i,

	input wire                   stallreq_from_id,

  //来自执行阶段的暂停请求
	input wire                   stallreq_from_ex,

	output reg[`RegBus]          new_pc,
	output reg                   flush,	
	output reg[5:0]              stall       
	
);


	always @ (*) begin
		if(rst == `RstEnable) begin
			stall <= 6'b000000;
			flush <= 1'b0;
			new_pc <= `ZeroWord;
		end else if(excepttype_i != `ZeroWord) begin
		  flush <= 1'b1;
		  stall <= 6'b000000;
			case (excepttype_i)
				32'h00000001:		begin   //interrupt
					new_pc <= `ExceptionBegin;
				end
				32'h00000008:		begin   //syscall
					new_pc <= `ExceptionBegin;
				end
				32'h0000000a:		begin   //inst_invalid
					new_pc <= `ExceptionBegin;
				end
				32'h0000000d:		begin   //trap
					new_pc <= `ExceptionBegin;
				end
				32'h0000000c:		begin   //ov
					new_pc <= `ExceptionBegin;
				end
				32'h0000000e:		begin   //eret
					new_pc <= cp0_epc_i;
				end
				default	: begin
				end
			endcase 						
		end else if(stallreq_from_ex == `Stop) begin
			stall <= 6'b001111;
			flush <= 1'b0;		
		end else if(stallreq_from_id == `Stop) begin
			stall <= 6'b000111;	
			flush <= 1'b0;		
		end else begin
			stall <= 6'b000000;
			flush <= 1'b0;
			new_pc <= `ZeroWord;		
		end    //if
	end      //always
			

endmodule