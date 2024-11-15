`timescale 1ns/100ps
`define TESTNUM 50

module even_test
#(
    parameter SIZE_IN  = 16,
    parameter SIZE_OUT = $clog2(SIZE_IN)
);

    wire [SIZE_OUT - 1: 0] out;
    reg  [SIZE_IN  - 1: 0] num;
    reg                    clk;

    integer val = 1;

    always 
        #1 clk = ~clk;
   

    log2 
    #(.SIZE_IN(SIZE_IN), .SIZE_OUT(SIZE_OUT))
    log2
    (
        .num    (num),
        .degree (out)
    );

    initial begin 
        for (integer i = 0; i < SIZE_IN; i = i + 1) begin
            #10;
            num = val;
            val = val * 2;
            #10;
            $display("num = %d  degree = %d ", num, out);
        end

        $finish;
	end
endmodule
