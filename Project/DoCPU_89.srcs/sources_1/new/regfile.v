`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    通用寄存器，共32个
// Vision   0.0
// Auther   Ray
//////////////////////////////////////////////////////////////////////////////////

module regfile(

	input wire clk,
	input wire rst,
	
	//写端口
	input wire we,
	input wire[`RegAddrBus]	waddr,
	input wire[`RegBus]		wdata,
	
	//读端口1
	input wire										re1,
	input wire[`RegAddrBus]			  raddr1,
	output reg[`RegBus]           rdata1,
	
	//读端口2
	input wire										re2,
	input wire[`RegAddrBus]			  raddr2,
	output reg[`RegBus]           rdata2
	
);

	reg[`RegBus]  regs[0:`RegNum-1];

    initial begin
        regs[0] <= 0; regs[1] <= 0; regs[2] <= 0; regs[3] <= 0; regs[4] <= 0;
        regs[5] <= 0; regs[6] <= 0; regs[7] <= 0; regs[8] <= 0; regs[9] <= 0;
        regs[10] <= 0; regs[11] <= 0; regs[12] <= 0; regs[13] <= 0; regs[14] <= 0;
        regs[15] <= 0; regs[16] <= 0; regs[17] <= 0; regs[18] <= 0; regs[19] <= 0;
        regs[20] <= 0; regs[21] <= 0; regs[22] <= 0; regs[23] <= 0; regs[24] <= 0;
        regs[25] <= 0; regs[26] <= 0; regs[27] <= 0; regs[28] <= 0; regs[29] <= 0;
        regs[30] <= 0; regs[31] <= 0;
    end

	always @ (posedge clk) begin
		if (rst == `RstDisable) begin
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	always @ (*) begin
		if(rst == `RstEnable) begin
			  rdata1 <= `ZeroWord;
	  end else if(raddr1 == `RegNumLog2'h0) begin
	  		rdata1 <= `ZeroWord;
	  end else if((raddr1 == waddr) && (we == `WriteEnable) 
	  	            && (re1 == `ReadEnable)) begin
	  	  rdata1 <= wdata;
	  end else if(re1 == `ReadEnable) begin
	      rdata1 <= regs[raddr1];
	  end else begin
	      rdata1 <= `ZeroWord;
	  end
	end

	always @ (*) begin
		if(rst == `RstEnable) begin
			  rdata2 <= `ZeroWord;
	  end else if(raddr2 == `RegNumLog2'h0) begin
	  		rdata2 <= `ZeroWord;
	  end else if((raddr2 == waddr) && (we == `WriteEnable) 
	  	            && (re2 == `ReadEnable)) begin
	  	  rdata2 <= wdata;
	  end else if(re2 == `ReadEnable) begin
	      rdata2 <= regs[raddr2];
	  end else begin
	      rdata2 <= `ZeroWord;
	  end
	end

endmodule