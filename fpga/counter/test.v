`include "decoder.v"

module numbers
(
    input   clk,
    input  KEY3,
    input [3: 0] switches,

    output wire [6: 0] HEX0
);

    wire [6: 0] hex0;
    reg reset;

    decoder decoder
    (
        .HEX0(hex0),
        .hex_num(switches)
    );


        

    always @(posedge clk)
        reset <= ~KEY3;
        

    assign HEX0 = reset ? 7'h7f : hex0;

    endmodule
