
`timescale 1ns/100ps
`define TESTNUM 50

module dec_test;

    wire [7: 0] out;
    reg         clk;
    reg  [2: 0]   N;

    always 
        #1 clk = ~clk;
   

    decoder decoder
    (
         .N   (  N),
         .out (out)
    );

    initial begin 

        for (integer i = 0; i < `TESTNUM; i = i + 1) begin
            #10;
            $display("  ");

            N = $random;
            #10;

            $display("N = %d  -->>  %b", N, out);
        end
        $finish;
	end
endmodule
