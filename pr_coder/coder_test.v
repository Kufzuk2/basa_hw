`timescale 1ns/100ps
`define TESTNUM 50

module dec_test;

    reg  [7: 0] num;
    reg         clk;
    wire [2: 0] out;

    always 
        #1 clk = ~clk;
   

    pr_coder pr_coder
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

            $display("N = %d = %b -->>  %d", num, num, out);
        end
        $finish;
	end
endmodule
