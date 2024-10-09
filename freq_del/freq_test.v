`timescale 1ns/100ps

module freq_test
#(
    parameter      EVEN_DIV = 14,
    parameter  COUNTER_SIZE = $clog2(EVEN_DIV),
    parameter COUNT_BOARDER = EVEN_DIV / 2 - 1,

    // for impuls
    parameter  IMP_WAIT = 8
);

    reg   clk;
    reg reset;

    freq_del   
        #(.EVEN_DIV(EVEN_DIV), 
          .IMP_WAIT(IMP_WAIT))
    freq_del 
        (      .clk(clk     ),
             .reset(reset   )
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

