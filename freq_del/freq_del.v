module freq_del
(
    input clk,
    input reset
);
    
    reg [2: 0]  counter;
    reg [2: 0] counter2;
    reg            clk6;
    wire           imp5;

    assign imp5 = (counter2 == 3'h4);

    always @(posedge clk)
        clk6     <= ~reset ? ((counter  == 3'h5) ? ~clk6 :            clk6) :        ~reset;
   
    always @(posedge clk)
        counter  <= ~reset ? ((counter  == 3'h5) ?  3'h0 : counter  + 3'h1) : {2'h0, ~reset};

    always @(posedge clk)
        counter2 <= ~reset ? ((counter2 == 3'h4) ?  3'h0 : counter2 + 3'h1) : {2'h0, ~reset};

endmodule
