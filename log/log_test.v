`timescale 1ns/100ps
`define TESTNUM 50

module even_test;

    wire [2: 0] out;
    reg         clk;
    reg  [7: 0] num;


    always 
        #1 clk = ~clk;
   

    log2 log2
    (
        .num    (num),
        .degree (out)
    );

    initial begin 
        #10;
        num = 1;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 2;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 4;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 8;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 16;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 32;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 64;
        #10;
        $display("num = %d  degree = %d ", num, out);

        #10;
        num = 128;
        #10;
        $display("num = %d  degree = %d ", num, out);

        $finish;
	end
endmodule
