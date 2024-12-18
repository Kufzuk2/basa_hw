module counter
(
    input  wire  clk,
    input  wire KEY0,  // reset
    input  wire KEY1,  // inc
    input  wire KEY2,  // dec

    output wire [6: 0] HEX0
);

    reg  [3: 0] counter;
    wire [6: 0] hex_local;
    
    reg but0_1;
    reg but0_2;
    reg but0;

    reg but1_1;
    reg but1_2;
    reg but1;
    
    reg but2_1;
    reg but2_2;
    reg but2;


    decoder decoder
    (
        .HEX0(hex_local),
        .hex_num(counter)
    );


    //reset
    always @(posedge clk) begin
        but0_1 <=   KEY0;
        but0_2 <= but0_1;
    end
    always @(posedge clk)
        but0 <= ~but0_1 & but0_2;

    //inc
    always @(posedge clk) begin
        but1_1 <=   KEY1;
        but1_2 <= but1_1;
    end
    always @(posedge clk)
        but1 <= but1_1 & ~but1_2;


    //dec
    always @(posedge clk) begin
        but2_1 <=   KEY2;
        but2_2 <= but2_1;
    end
    always @(posedge clk)
        but2 <= ~but2_1 & but2_2;





    always @(posedge clk) begin
        if (but0)
            counter <= 0;
        else
            counter <= but1 ? counter + 1 : 
                       but2 ? counter - 1 :
                                   counter;
    end

    assign HEX0 = hex_local; 
endmodule
