`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    Êý¾Ý´æ´¢Æ÷
// Vision   0.0
// Auther   Ray
//////////////////////////////////////////////////////////////////////////////////

module dmem(
	input wire clk,
	input wire	ce,
	input wire	we,
	input wire[`DataAddrBus] addr_in,
	input wire[3:0] sel,
	input wire[`DataBus] data_i,
	output reg[`DataBus] data_o,
	output wire[`DataBus] result
);
	reg[`ByteWidth]  data_mem0[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem1[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem2[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem3[0:`DataMemNum-1];

    wire [`DataAddrBus] addr;
    assign addr = addr_in - `DataBegin;
    assign result = {data_mem3[0],data_mem2[0],data_mem1[0],data_mem0[0]};

	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			//data_o <= ZeroWord;
		end else if(we == `WriteEnable) begin
			  if (sel[3] == 1'b1) begin
		      data_mem3[addr[`DataMemNumLog2+1:2]] <= data_i[31:24];
		    end
			  if (sel[2] == 1'b1) begin
		      data_mem2[addr[`DataMemNumLog2+1:2]] <= data_i[23:16];
		    end
		    if (sel[1] == 1'b1) begin
		      data_mem1[addr[`DataMemNumLog2+1:2]] <= data_i[15:8];
		    end
			  if (sel[0] == 1'b1) begin
		      data_mem0[addr[`DataMemNumLog2+1:2]] <= data_i[7:0];
		    end			   	    
		end
	end
	
	always @ (*) begin
		if (ce == `ChipDisable) begin
			data_o <= `ZeroWord;
	  end else if(we == `WriteDisable) begin
		    data_o <= {data_mem3[addr[`DataMemNumLog2+1:2]],
		               data_mem2[addr[`DataMemNumLog2+1:2]],
		               data_mem1[addr[`DataMemNumLog2+1:2]],
		               data_mem0[addr[`DataMemNumLog2+1:2]]};
		end else begin
				data_o <= `ZeroWord;
		end
	end		

endmodule