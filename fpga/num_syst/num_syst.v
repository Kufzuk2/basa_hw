
`define DISPLAY_0 ~7'b0111111
`define DISPLAY_OVERFLOW ~7'b1100011
`include "dd_iter.v"
`include "double_dabble.v"
`include "decoder.v"
module num_syst
(
    input   clk,  // ASSIGN CLOCK_50
    input  KEY0,  // ASSIGN KEY_0
    input  KEY1,  // ASSIGN KEY_1
    input [7: 0] switches, // ASSIGN SW_[7:0]

    output wire [7: 0] LEDR, // ASSIGN LEDR_[7:0]
    output  reg [6: 0] HEX4, // ASSIGN HEX4_[6:0]
    output  reg [6: 0] HEX5, // ASSIGN HEX5_[6:0]
    output  reg [6: 0] HEX6, // ASSIGN HEX6_[6:0]
    output  reg [6: 0] HEX7, // ASSIGN HEX7_[6:0]

    //output wire old_LEDG8 // ASSIGN SW_8
    output reg  LEDG8 // ASSIGN SW_8
);

    assign LEDR = switches;

    // local hex ouputs
    wire [6: 0] hex4_loc;
    wire [6: 0] hex5_loc;
    wire [6: 0] hex6_loc;
    wire [6: 0] hex7_loc;
    

    wire [1: 0]    dec_offset;
  

	always @(posedge clk) begin
        if (rst_pushed)
            LEDG8 <= 0;
        else
            LEDG8 <= trans_pushed ? dec_overflow : LEDG8;
    end
    

   // assign LEDG8 = dec_overflow;


    // rst regs
    reg rst_push_1;
    reg rst_push_2;
    reg rst_pushed;

   
    // translate regs
    reg trans_push_1;
    reg trans_push_2;
    reg trans_pushed;


    // connection with decoder
    wire [3: 0]   hex_left;
    wire [3: 0]  hex_right;
    wire [3: 0]  dec_right;
    wire [3: 0]   dec_left;
    wire [7: 0] dec_in_hex;
    wire [3: 0]  dec_hundr;

    assign hex_left  =   switches[7: 4];
    assign hex_right =   switches[3: 0];
    assign dec_left  = dec_in_hex[7: 4];
    assign dec_right = dec_in_hex[3: 0];

	wire dec_overflow;
    assign dec_overflow = (switches > 8'h63);
/*
	 reg dec_overflow;
	 always @(posedge clk) begin
		if (rst_pushed)
			dec_overflow <= 0;
		else
			dec_overflow <= switches > 8'h63;
*/

    decoder dec_hex_right
    (
        .HEX0(hex4_loc),
        .hex_num(hex_right)
    );

    decoder dec_hex_left
    (
        .HEX0(hex5_loc),
        .hex_num(hex_left)
    );

    decoder dec_dec_right
    (
        .HEX0(hex6_loc),
        .hex_num(dec_right)
    );

    decoder dec_dec_left
    (
        .HEX0(hex7_loc),
        .hex_num(dec_left)
    );




    // syncr reset logic
    always @(posedge clk) begin
        rst_push_1 <=       KEY0;
        rst_push_2 <= rst_push_1;
    end

    always @(posedge clk)
        rst_pushed <= ~rst_push_1 & rst_push_2;

        
    // syncr translation button logic
    always @(posedge clk) begin
        trans_push_1 <=         KEY1;
        trans_push_2 <= trans_push_1;
    end

    always @(posedge clk)
        trans_pushed <= ~trans_push_1 & trans_push_2;


    //hex display logic
    always @(posedge clk) begin
        if (rst_pushed) begin
            HEX4 <= `DISPLAY_0;  
            HEX5 <= `DISPLAY_0;  
        end else begin
            HEX4 <= trans_pushed ? hex4_loc : HEX4;  
            HEX5 <= trans_pushed ? hex5_loc : HEX5;  
            if (trans_pushed) begin
                $display("switches = %b, hex_in_hex = %h, dec_in_hex = %h \n",
                          switches, {hex_left, hex_right}, dec_in_hex);
            end
        end
	end
	
	
	double_dabble vin_to_bcd
	(
		.bin(switches),
		.bcd({dec_hundr, dec_in_hex[7: 4], dec_in_hex[3: 0]})
	);
	
	
	/*	  
	wire [7: 0] dec_in_hexl [7: 0];	  
	wire [1: 0] dec_offsetl [7: 0];
    //dec count logic
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_block
            if (i == 0) begin
                assign dec_in_hexl[i] = 0;
                assign dec_offsetl[i] = 0;
            end else begin
                assign dec_in_hexl[i] = dec_in_hexl[i - 1] + switches[i - 1] - (dec_in_hex[i - 1] > 8'h9) & 8'ha;
                assign dec_offsetl[i] = dec_offsetl[i - 1] + (dec_in_hexl[i - 1] > 9);
            end
        end
    endgenerate
	 
	 assign dec_in_hex = dec_in_hexl[7];
	 assign dec_offset = dec_offsetl[7];
*/
    //dec display logic
    always @(posedge clk)
        if (rst_pushed) begin
            HEX6 <= `DISPLAY_0;  
            HEX7 <= `DISPLAY_0;  
        end else begin
            HEX6 <= ~trans_pushed ? HEX6 :
                     dec_overflow ? `DISPLAY_OVERFLOW : hex6_loc;  

            HEX7 <= ~trans_pushed ? HEX7 :
                     dec_overflow ? `DISPLAY_OVERFLOW : hex7_loc;  
        end

endmodule




