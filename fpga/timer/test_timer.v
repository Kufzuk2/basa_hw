`timescale 10ns/1ns 

module test_timer;

    reg clk;
    reg KEY0;
    reg KEY1;

    timer timer
    (
        .clk(clk),
        .KEY0(KEY0),
        .KEY1(KEY1)
    );


    always
        #1 clk = ~clk;

    initial begin
        clk  <= 0;
        KEY0 <= 1;
        KEY1 <= 1;
    end


    initial begin
		$dumpfile("dump.vcd"); $dumpvars(0, test_timer);
        #5; 
        KEY0 <= 0;
        #2;
        KEY0 <= 1;
        #10; 
        KEY1 <= 0;
        #2; 
        KEY1 <= 1;

        #30000000;
//        #150000000;
        $finish;
    end




endmodule
