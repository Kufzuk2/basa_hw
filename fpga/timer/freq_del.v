module freq_del
#(
    parameter EVEN_DIV = 6
)
(
    input  wire     clk,
    input  wire   reset,
    input  wire   start,
    input  wire    work,

    output wire clk_div
);
    
    localparam  COUNTER_SIZE = $clog2(EVEN_DIV);
    localparam COUNT_BOARDER = EVEN_DIV / 2 - 1;
    
    output reg [COUNTER_SIZE - 1: 0]    counter;

    assign clk_div = (counter > COUNT_BOARDER);
    always @(posedge clk) begin
        if (reset | start)
            counter <= 0;
        else
            counter <= ~work ? counter : 
                       (counter == EVEN_DIV - 1) ? 'h0 : 
                        counter + 'h1;
    end
endmodule
