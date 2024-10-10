module freq_del
#(
    parameter      EVEN_DIV = 6,
    parameter  COUNTER_SIZE = $clog2(EVEN_DIV),
    parameter COUNT_BOARDER = EVEN_DIV / 2 - 1,


    // for impuls
    parameter      IMP_WAIT = 5
)
(
    input  wire     clk,
    input  wire   reset,
    
    output wire clk_div,
    output wire     imp
);
    
    output reg [COUNTER_SIZE - 1: 0] counter;

    // freq division
    assign clk_div = (counter > COUNT_BOARDER);
    always @(posedge clk)
        if (reset)
            counter <= 0;
        else
            counter <= (counter == EVEN_DIV - 1) ? 'h0 : counter + 'h1;


/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////


    reg [2: 0] counter2;

    // impulse every IMP_WAIT cycles
    assign imp = (counter2 == IMP_WAIT - 1);
    always @(posedge clk)
        if (reset)
            counter2 <= 0;
        else
            counter2 <= (counter2 == IMP_WAIT - 1) ? 'h0 : counter2 + 'h1;

endmodule
