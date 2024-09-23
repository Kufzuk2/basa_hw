`timescale 1ns/100ps

module freq_test;

reg   clk;
reg reset;

freq_del   freq_test 
        (  .clk(clk  ),
         .reset(reset)
        );

    always 
        #1 clk = ~clk;

    initial begin
        clk   <= 0;
        reset <= 1;
    end

    initial begin
		$dumpfile("dump.vcd"); $dumpvars(0, freq_test);
        #5; 
        reset = 0;
        #130;
        $finish;
    end

endmodule

