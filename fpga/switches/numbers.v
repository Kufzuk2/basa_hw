//`include "decoder.v"

module numbers
(
    input   clk,
    input  KEY3, //reset
    input  KEY0, 
    input [3: 0] switches,

    output reg [6: 0] HEX0
);

    wire [6: 0] hex_local;

    reg reset;
    reg but_push_1;
    reg but_push_2;
    reg but_pushed;


    decoder decoder
    (
        .HEX0(hex_local),
        .hex_num(switches)
    );


    always @(posedge clk) begin
        but_push_1 <=       KEY0;
        but_push_2 <= but_push_1;
    end


    always @(posedge clk)
        but_pushed <= ~but_push_1 & but_push_2;

    always @(posedge clk)
        reset <= ~KEY3;
        

    always @(posedge clk) begin
        if (reset)
            HEX0 <= 7'h7f;
        else
            HEX0 <= but_pushed ? hex_local : HEX0;

    end
endmodule




