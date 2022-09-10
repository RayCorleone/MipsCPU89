`include "D:\Ray\Vivado\DoCPU_89\DoCPU_89.srcs\sources_1\new\defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    DoCPU下板模块
// Vision   1.0
// Auther   Ray 
//////////////////////////////////////////////////////////////////////////////////

module docpu_board(
    input clk_in,       // 输入时钟
    input reset,        // 复位信号
    input en_clk,       // 时钟选择
    input [1:0] choose, // 显示选择
    output [7:0] o_seg, 
    output [7:0] o_sel
);    
    wire clk_cpu;
    wire clk_seg;
    wire [31:0] i_data;
    wire [31:0] inst, pc, result;
    
    /////////////////////////////////////////////////////////////////////
    // 选择显示 inst,pc,result
    divider#(4) div_seg (clk_in, reset, clk_seg);
    divider#(100000) div_cpu (clk_in, reset, clk_cpu);
    seg7x16 seg7 (clk_seg, reset, i_data, o_seg, o_sel);
    assign i_data = (choose[1]) ? inst :((choose[0]) ? pc : result);

    /////////////////////////////////////////////////////////////////////
    // pcpu_onboard 顶层部分
    wire clk_real;
    assign clk_real = en_clk ? clk_seg : clk_cpu;
    docpu_top docpu_top(clk_real, reset, pc, inst, result);

endmodule