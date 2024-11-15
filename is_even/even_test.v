//`include "is_even.v"
`timescale 1ns/100ps
`define TESTNUM 50

module even_test;

    parameter NUM_SIZE  =  12;
    wire                  out;
    reg                   clk;
    reg [NUM_SIZE - 1: 0] num;

    always 
        #1 clk = ~clk;
   

    is_even #(.NUM_SIZE(NUM_SIZE)) is_even
    (
        .num (num),
        .out (out)
    );

    initial begin 

        for (integer i = 0; i < `TESTNUM; i = i + 1) begin
            #10;
            $display("  ");

            num = $random;
            #10;

            if (out)
                $display("num = %d  is even", num);
            else
                $display("num = %d  is  odd", num);
        end
        $finish;
	end
endmodule
