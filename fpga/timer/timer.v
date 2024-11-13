// frequency 50 MHz
`define DISPLAY_0 ~7'b0111111


module timer
#(
    parameter MIN_COUNT_IN_MS = 100,
    parameter FREQ_MHZ        = 50
)
(
    input wire clk,
    input wire KEY0, //reset
    input wire KEY1, //start stop
    input wire KEY2, //write
    

    output  reg [6: 0] HEX0, // split sec
    output  reg [6: 0] HEX1, // right dig
    output  reg [6: 0] HEX2, // left  dig

    output  reg [6: 0] HEX4, // right dig
    output  reg [6: 0] HEX5 // left  dig

    
);
    localparam DIV_FREQ = FREQ_MHZ * 1000 * MIN_COUNT_IN_MS;

    reg [3: 0]  split_count;
    reg [3: 0] s_unit_count;
    reg [3: 0]  s_dec_count;

    wire [3: 0]  split_tmp;
    wire [3: 0] s_unit_tmp;
    wire [3: 0]  s_dec_tmp;

    reg work; //1 if timer is working now
    
    wire [6: 0] hex0_loc;
    wire [6: 0] hex1_loc;
    wire [6: 0] hex2_loc;
    wire [6: 0] hex4_loc;
    wire [6: 0] hex5_loc;

    wire overflow_split;
    wire overflow_unit;
    wire overflow_dec;

    assign overflow_split = ( split_count == 4'h9);
    assign overflow_unit  = (s_unit_count == 4'h9);
    assign overflow_dec   = ( s_dec_count == 4'h9);

    decoder for_hex0
    (
        .HEX0(hex0_loc),
        .hex_num(split_count)
    );

    decoder for_hex1
    (
        .HEX0(hex1_loc),
        .hex_num(s_unit_count)
    );

    decoder for_hex2
    (
        .HEX0(hex2_loc),
        .hex_num(s_dec_count)
    );

    wire imp;

    freq_del
    #(.IMP_WAIT(DIV_FREQ))
    freq_del
    (
        .clk(clk),
        .reset(rst),
        .imp(imp)
    );

    reg rst_push_1;
    reg rst_push_2;
    reg rst;

    reg hold_rst;
    reg hold_start;

    reg start_push_1;
    reg start_push_2;
    reg start;

    reg write_push_1;
    reg write_push_2;
    reg write;

    // syncr reset button logic
    always @(posedge clk) begin
        rst_push_1 <=       KEY0;
        rst_push_2 <= rst_push_1;
    end

    always @(posedge clk)
        rst <= ~rst_push_1 & rst_push_2;

        
    // syncr translation button logic
    always @(posedge clk) begin
        start_push_1 <=         KEY1;
        start_push_2 <= start_push_1;
    end

    always @(posedge clk)
        start <= ~start_push_1 & start_push_2;


    // syncr translation button logic
    always @(posedge clk) begin
        write_push_1 <=         KEY2;
        write_push_2 <= write_push_1;
    end

    always @(posedge clk)
        write <= ~write_push_1 & write_push_2;


// hold rst logic

    always @(posedge clk) begin
        if (rst)
            hold_rst <= 1;
        else
            hold_rst <= (imp) ? 0 : hold_rst;
    end

    always @(posedge clk) begin
        if (start)
            hold_start <= 1;
        else
            hold_start <= (imp & ~work) ? 0 : hold_rst;
    end

    
    always @(posedge clk) begin // offset 1 extra cycle /////// is it bad????? seems not
        if (rst)
            work <= 0;
        else
            work <= start ? ~work : work;
    end

    always @(posedge imp) begin
        if (rst)
            split_count <= 0;
        else
            split_count <= ~(work & imp)   ?        split_count    :
                            overflow_split ? 4'h0 : split_count + 1;
    end

    
    always @(posedge clk) begin
        if (rst)
            s_unit_count <= 0;
        else
            s_unit_count <= ~(overflow_split & work & imp) ? s_unit_count : 
                              overflow_unit & overflow_split  ? 4'h0                 :
                              s_unit_count + 1;
    end

    always @(posedge clk) begin
        if (rst)
            s_dec_count <= 0;
        else
            s_dec_count <= ~(overflow_unit & overflow_split & work & imp)  ? s_dec_count : 
                             overflow_dec & overflow_unit & overflow_split ? 4'h0                :
                             s_dec_count + 1;
    end


    always @(posedge clk)
        if (rst) begin
            HEX0 <= `DISPLAY_0;  
            HEX1 <= `DISPLAY_0;  
            HEX2 <= `DISPLAY_0;  
        end else begin
            HEX0 <= hex0_loc;  
            HEX1 <= hex1_loc;  
            HEX2 <= hex2_loc;  
        end


    always @(posedge clk)
        if (rst) begin
            HEX4 <= `DISPLAY_0;  
            HEX5 <= `DISPLAY_0;  
        end else begin
	    HEX4 <= ~write ?     HEX4:
	             work  ? hex1_loc:
		           `DISPLAY_0;  

	    HEX5 <= ~write ?     HEX5:
	             work  ? hex2_loc:
		           `DISPLAY_0;  
        end


endmodule
