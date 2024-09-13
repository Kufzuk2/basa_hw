`include "is_even.v"
`timescale 1ns/100ps


module testbench;

    always 
        #1 clk = ~clk;
   

    is even #(.)


    initial begin 
        #10;
        reset = 0;
        #10;

        $finish;
	end

