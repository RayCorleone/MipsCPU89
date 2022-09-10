`timescale 10ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Usage    流水线顶层测试模块
// Vision   0.0
// Auther   Ray 
//////////////////////////////////////////////////////////////////////////////////

module docpu_top_tb;
    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] inst;
    wire [31:0] answer;
    integer file_output;
    
    reg     ok;
    integer done;

    docpu_top uut(clk,reset,pc,inst,answer);
  
    initial clk<=1;
    always #5 clk<=~clk;
    
    integer inst_count;
    reg [31:0] pc4,pc3,pc2,pc1,inst4,inst3,inst2,inst1;

    initial begin
        file_output = $fopen("C:/Users/14065/Desktop/DoCPU89/result.txt");
        #1 reset<=1;    #27 reset<=0;   inst_count<=0;  ok<=1;  done<=5;
        pc4<=0;     pc3<=0;     pc2<=0;     pc1<=0;
        inst4<=0;   inst3<=0;   inst2<=0;   inst1<=0;
    end

    always@(posedge clk) begin
        if(ok&&inst4===32'bx)
            done<=done-1;
        if(done==0)
            $stop;
        if(inst_count<4) begin
            inst_count<=inst_count+1;
            pc1<=pc;        pc2<=pc1;       pc3<=pc2;       pc4<=pc3;
            inst1<=inst;    inst2<=inst1;   inst3<=inst2;   inst4<=inst3;
        end
        else if(ok) begin
            $fdisplay(file_output,"pc: %h",pc4);
            $fdisplay(file_output,"instr: %h",inst4);
            $fdisplay(file_output,"regfile0: %h",docpu_top_tb.uut.docpu.regfile1.regs[0]);
            $fdisplay(file_output,"regfile1: %h",docpu_top_tb.uut.docpu.regfile1.regs[1]);
            $fdisplay(file_output,"regfile2: %h",docpu_top_tb.uut.docpu.regfile1.regs[2]);
            $fdisplay(file_output,"regfile3: %h",docpu_top_tb.uut.docpu.regfile1.regs[3]);
            $fdisplay(file_output,"regfile4: %h",docpu_top_tb.uut.docpu.regfile1.regs[4]);
            $fdisplay(file_output,"regfile5: %h",docpu_top_tb.uut.docpu.regfile1.regs[5]);
            $fdisplay(file_output,"regfile6: %h",docpu_top_tb.uut.docpu.regfile1.regs[6]);
            $fdisplay(file_output,"regfile7: %h",docpu_top_tb.uut.docpu.regfile1.regs[7]);
            $fdisplay(file_output,"regfile8: %h",docpu_top_tb.uut.docpu.regfile1.regs[8]);
            $fdisplay(file_output,"regfile9: %h",docpu_top_tb.uut.docpu.regfile1.regs[9]);
            $fdisplay(file_output,"regfile10: %h",docpu_top_tb.uut.docpu.regfile1.regs[10]);
            $fdisplay(file_output,"regfile11: %h",docpu_top_tb.uut.docpu.regfile1.regs[11]);
            $fdisplay(file_output,"regfile12: %h",docpu_top_tb.uut.docpu.regfile1.regs[12]);
            $fdisplay(file_output,"regfile13: %h",docpu_top_tb.uut.docpu.regfile1.regs[13]);
            $fdisplay(file_output,"regfile14: %h",docpu_top_tb.uut.docpu.regfile1.regs[14]);
            $fdisplay(file_output,"regfile15: %h",docpu_top_tb.uut.docpu.regfile1.regs[15]);
            $fdisplay(file_output,"regfile16: %h",docpu_top_tb.uut.docpu.regfile1.regs[16]);
            $fdisplay(file_output,"regfile17: %h",docpu_top_tb.uut.docpu.regfile1.regs[17]);
            $fdisplay(file_output,"regfile18: %h",docpu_top_tb.uut.docpu.regfile1.regs[18]);
            $fdisplay(file_output,"regfile19: %h",docpu_top_tb.uut.docpu.regfile1.regs[19]);
            $fdisplay(file_output,"regfile20: %h",docpu_top_tb.uut.docpu.regfile1.regs[20]);
            $fdisplay(file_output,"regfile21: %h",docpu_top_tb.uut.docpu.regfile1.regs[21]);
            $fdisplay(file_output,"regfile22: %h",docpu_top_tb.uut.docpu.regfile1.regs[22]);
            $fdisplay(file_output,"regfile23: %h",docpu_top_tb.uut.docpu.regfile1.regs[23]);
            $fdisplay(file_output,"regfile24: %h",docpu_top_tb.uut.docpu.regfile1.regs[24]);
            $fdisplay(file_output,"regfile25: %h",docpu_top_tb.uut.docpu.regfile1.regs[25]);
            $fdisplay(file_output,"regfile26: %h",docpu_top_tb.uut.docpu.regfile1.regs[26]);
            $fdisplay(file_output,"regfile27: %h",docpu_top_tb.uut.docpu.regfile1.regs[27]);
            $fdisplay(file_output,"regfile28: %h",docpu_top_tb.uut.docpu.regfile1.regs[28]);
            $fdisplay(file_output,"regfile29: %h",docpu_top_tb.uut.docpu.regfile1.regs[29]);
            $fdisplay(file_output,"regfile30: %h",docpu_top_tb.uut.docpu.regfile1.regs[30]);
            $fdisplay(file_output,"regfile31: %h",docpu_top_tb.uut.docpu.regfile1.regs[31]);
            pc1<=pc;        pc2<=pc1;       pc3<=pc2;       pc4<=pc3;
            inst1<=inst;    inst2<=inst1;   inst3<=inst2;   inst4<=inst3;
        end
    end
endmodule