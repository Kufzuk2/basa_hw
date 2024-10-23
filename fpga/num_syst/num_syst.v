
`define DISPLAY_0 7'b0111111

module numbers
(
    input   clk,
    input  KEY0, //reset
    input  KEY1, // translate
    input [7: 0] switches,

    output wire [7: 0] LEDR,
    output  reg [6: 0] HEX4, //1st digit in hex
    output  reg [6: 0] HEX5, //2nd digit in hex
    output  reg [6: 0] HEX6, //1st digit in dec
    output  reg [6: 0] HEX7  //2nd digit in dec
);

    assign LEDR = switches;

    // local hex ouputs
    wire [6: 0] hex4_loc;
    wire [6: 0] hex5_loc;
    wire [6: 0] hex6_loc;
    wire [6: 0] hex7_loc;


    // rst regs
    reg rst_push_1;
    reg rst_push_2;
    reg rst_pushed;

   
    // translate regs
    reg trans_push_1;
    reg trans_push_2;
    reg trans_pushed;


    // hex 
    wire [3: 0] hex_left;
    wire [3: 0] hex_right;

    assign hex_left  = switches[7: 4];
    assign hex_right = switches[3: 0];

    decoder dec_hex_left
    (
        .HEX0(hex4_loc),
        .hex_num(hex_left)
    );

    decoder dec_hex_right
    (
        .HEX0(hex5_loc),
        .hex_num(hex_right)
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
        trans_push_1 <=         KEY0;
        trans_push_2 <= trans_push_1;
    end

    always @(posedge clk)
        trans_pushed <= ~trans_push_1 & trans_push_2;


    //hex display logic
    always @(posedge clk)
        if (rst_pushed) begin
            HEX4 <= `DISPLAY_0;  
            HEX5 <= `DISPLAY_0;  
        end else
            HEX4 <= hex4_loc;  
            HEX5 <= hex5_loc;  
        end
        



    always @(posedge clk) begin
        if (reset)
            HEX0 <= 7'h7f;
        else
            HEX0 <= rst_pushed ? hex_local : HEX0;

    end
endmodule




