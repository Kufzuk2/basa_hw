// 

module blink
(
    input clk, // ASSIGN CLOCK_50
    input KEY0, // ASSIGN KEY_0
    input KEY1, // ASSIGN KEY_1
    input [13:0]switches, // ASSIGN SW_[13:0]    
    output wire LEDG8 // ASSIGN LEDG_8
);

    reg [25: 0] tact_counter;
    reg [9 : 0]   ms_counter;
    reg led;

    assign LEDG8 = change & led;

    wire rdy_ms;
    wire nul_ms;
    assign rdy_ms = (tact_counter == 'd50000);
    assign nul_ms = (ms_counter == (switches >> 2));


    always @(posedge clk) begin
        if (rst)
            tact_counter <= 0;
        else
            tact_counter <= rdy_ms ? 0 : tact_counter + 1;
    end

    always @(posedge clk) begin
        if (rst)
            ms_counter <= 0;
        else
            ms_counter <= nul_ms ? 0             :
                          rdy_ms ? ms_counter + 1: 
                                       ms_counter;
    end
    
    always @(posedge clk) begin
        if (rst)
            led <= 0;
        else
            led <= nul_ms ? ~led : led;
    end


    reg rst_push_1;
    reg rst_push_2;
    reg rst;
    
    reg change_push_1;
    reg change_push_2;
    reg change;

    // syncr reset button logic
    always @(posedge clk) begin
        rst_push_1 <=       KEY0;
        rst_push_2 <= rst_push_1;
    end

    always @(posedge clk)
        rst <= ~rst_push_1 & rst_push_2;

        
    // syncr period change button logic
    always @(posedge clk) begin
        change_push_1 <=         KEY1;
        change_push_2 <= change_push_1;
    end

    always @(posedge clk)
        change <= ~change_push_1 & change_push_2;




endmodule
