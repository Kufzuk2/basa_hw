`timescale 10ns/1ns 
`include "num_syst.v"

module test_num;

    reg clk;
    reg KEY0;
    reg KEY1;
    reg [7: 0] switches;

    num_syst num_syst
    (
        .clk(clk),
        .KEY0(KEY0),
        .KEY1(KEY1),
        .switches(switches)
    );


    always
        #1 clk = ~clk;

    initial begin
        clk  <= 0;
        KEY0 <= 1;
        KEY1 <= 1;
    end


    initial begin
		$dumpfile("dump.vcd"); $dumpvars(0, test_num);
        #5; 
        KEY0 <= 0;
        #2;
        KEY0 <= 1;

        #10;
        switches <= 8'h20;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;
        #4;

        #10;
        switches <= 8'h11;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #10;
        switches <= 8'h20;
        #4; 

        #10;
        switches <= 8'h1f;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #10;
        switches <= 8'h80;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #10;
        switches <= 8'hff;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #10;
        switches <= 8'h0f;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;


        #10;
        switches <= 8'h12;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;


        #10;
        switches <= 8'h32;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;


        #10;
        switches <= 8'h24;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;


        #10;
        switches <= 8'h16;
        #4; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #150;
//        #150000000;
        $finish;
    end




endmodule
