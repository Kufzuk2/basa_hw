module decoder
(
    input  wire [3: 0] hex_num,
    output wire [6: 0]    HEX0
);


    assign HEX0 = (hex_num == 4'h0) ? ~7'b0111111 :
                  (hex_num == 4'h1) ? ~7'b0000110 :
                  (hex_num == 4'h2) ? ~7'b1011011 :
                  (hex_num == 4'h3) ? ~7'b1001111 :
                  (hex_num == 4'h4) ? ~7'b1100110 :
                  (hex_num == 4'h5) ? ~7'b1101101 :
                  (hex_num == 4'h6) ? ~7'b1111101 :
                  (hex_num == 4'h7) ? ~7'b0000111 :
                  (hex_num == 4'h8) ? ~7'b1111111 :
                  (hex_num == 4'h9) ? ~7'b1101111 :
                  (hex_num == 4'ha) ? ~7'b1110111 :
                  (hex_num == 4'hb) ? ~7'b1111100 :
                  (hex_num == 4'hc) ? ~7'b0111001 :
                  (hex_num == 4'hd) ? ~7'b1011110 :
                  (hex_num == 4'he) ? ~7'b1111001 :
                  (hex_num == 4'hf) ? ~7'b1110001 :
                                                1 ;
endmodule



