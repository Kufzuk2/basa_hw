module freq_del
#(
    parameter IMP_WAIT = 5
)
(
    input  wire     clk,
    input  wire   reset,
    
    output wire     imp
);
    

/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////

		localparam count_size = $clog2(50000000);
    reg [count_size - 1: 0] counter2;

    // impulse every IMP_WAIT cycles
    assign imp = (counter2 == (IMP_WAIT - 1));
    always @(posedge clk)
        if (reset)
            counter2 <= 0;
        else
            counter2 <= (counter2 == (IMP_WAIT - 1)) ? 'h0 : counter2 + 'h1;

endmodule
