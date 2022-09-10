`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    DoCPU¶¥²ãÄ£¿é
// Vision   0.0
// Auther   Ray
//////////////////////////////////////////////////////////////////////////////////

module docpu_top(
	input clk,
	input rst,
    output [31:0] pc,
    output [31:0] inst,
    output [31:0] result
);
    //Á¬½ÓÖ¸Áî´æ´¢Æ÷
    wire rom_ce;
    wire mem_we_i;
    wire[`RegBus] mem_addr_i;
    wire[`RegBus] mem_data_i;
    wire[`RegBus] mem_data_o;
    wire[3:0] mem_sel_i; 
    wire mem_ce_i;   
    wire[5:0] int;
    wire timer_int;
    
    assign int = {5'b00000, timer_int};

    docpu docpu(
        .clk(clk),
        .rst(rst),
    
        .rom_addr_o(pc),
        .rom_data_i(inst),
        .rom_ce_o(rom_ce),

        .int_i(int),

        .ram_we_o(mem_we_i),
        .ram_addr_o(mem_addr_i),
        .ram_sel_o(mem_sel_i),
        .ram_data_o(mem_data_i),
        .ram_data_i(mem_data_o),
        .ram_ce_o(mem_ce_i),
        
        .timer_int_o(timer_int)
    );

    wire [31:0] a;
    assign a = pc - `TextBegin;
    imem imem(a[12:2],inst);

    dmem dmem(
        .clk(clk),
        .ce(mem_ce_i),
        .we(mem_we_i),
        .addr_in(mem_addr_i),
        .sel(mem_sel_i),
        .data_i(mem_data_i),
        .data_o(mem_data_o),
        .result(result)
    );

endmodule