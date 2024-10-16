
module counter
(
    input  wire  clk,
    input  wire KEY0,  // reset
    input  wire KEY1,  // inc
    input  wire KEY2,  // dec

    output wire [6: 0] HEX0
);

    reg [3: 0] counter;
    

    decoder decoder 
    (
    .counter(counter), 
       .HEX0(HEX0)
    );



    always @(posedge clk) begin
        if (KEY0)
            counter <= 0;
        else
            counter <= KEY1 ? counter + 1 : 
                       KEY2 ? counter - 1 :
                                   counter;

endmodule
