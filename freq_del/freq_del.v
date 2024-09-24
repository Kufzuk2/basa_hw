module freq_del
(
    input clk,
    input reset
);
    
    reg [2: 0]  counter;
    reg [2: 0] counter2;
    wire           imp5;
    wire           clk6;

    assign clk6 = (counter   > 3'h2);
    assign imp5 = (counter2 == 3'h4);
   
    always @(posedge clk)
        counter  <= ~reset ? ((counter  == 3'h5) ?  3'h0 : counter  + 3'h1) : {2'h0, ~reset};

    always @(posedge clk)
        counter2 <= ~reset ? ((counter2 == 3'h4) ?  3'h0 : counter2 + 3'h1) : {2'h0, ~reset};

endmodule
