`timescale 1ns/100ps
`define TESTNUM 50

module dec_test
#(
    parameter NUM_SIZE = 16,
    parameter OUT_SIZE = $clog2(NUM_SIZE)
);

    reg  [NUM_SIZE - 1: 0] num;
    wire [OUT_SIZE - 1: 0] out;
    reg                    clk;
    


    localparam MAX_OFFSET = $clog2(NUM_SIZE - OUT_SIZE);
    reg  [MAX_OFFSET - 1: 0] offset;

    always 
        #1 clk = ~clk;
   

    pr_coder 
        #(.NUM_SIZE(NUM_SIZE), .OUT_SIZE(OUT_SIZE))
    pr_coder
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
        
            $display("************************** \n",);
///   here with offset because almost each random number has 1 as 1st digit in
///    binary
       

        for (integer i = 0; i < `TESTNUM; i = i + 1) begin
            #10;
            $display("  ");

            offset = $random;
            num    = $random >> offset;
            num    =     num >> offset;

            #10;

            $display("N = %d = %b -->>  %d,  (offset = %d)", num, num, out, offset);
        end
        $finish;
	end
endmodule
