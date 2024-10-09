
`timescale 1ns/100ps
`define TESTNUM 50

module dec_test
#(
    parameter N_IN = 3,
    parameter OUT  = 2 ** N_IN
);
    
    wire [OUT  - 1: 0] out;
    reg  [N_IN - 1: 0]   N;
    reg                clk;

    always 
        #1 clk = ~clk;
   

    decoder 
            #(.N_IN(N_IN), .OUT(OUT))
    decoder
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
