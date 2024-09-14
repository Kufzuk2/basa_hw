`define MASK_1    8'd1  
`define MASK_2    8'd2  
`define MASK_4    8'd4  
`define MASK_8    8'd8  
`define MASK_16   8'd16  
`define MASK_32   8'd32  
`define MASK_64   8'd64 
`define MASK_128  8'd128  
`define MASK_256  8'd256  
`define MASK_BEDA 3'd0  

module log2
(
    input  wire [7: 0] num,
    output wire [2: 0] degree
);

    assign degree = ((num & `MASK_1   ) >> 0) * 3'h0 |
                    ((num & `MASK_2   ) >> 1) * 3'h1 |   
                    ((num & `MASK_4   ) >> 2) * 3'h2 |  
                    ((num & `MASK_8   ) >> 3) * 3'h3 |  
                    ((num & `MASK_16  ) >> 4) * 3'h4 |  
                    ((num & `MASK_32  ) >> 5) * 3'h5 |  
                    ((num & `MASK_64  ) >> 6) * 3'h6 |  
                    ((num & `MASK_128 ) >> 7) * 3'h7 ;  
                    // i suppose that there are no other options

endmodule
    


/*
assign degree = (num & `MASK_1   ) ? 0:
                    (num & `MASK_2   ) ? 1: 
                    (num & `MASK_4   ) ? 2: 
                    (num & `MASK_8   ) ? 3: 
                    (num & `MASK_16  ) ? 4: 
                    (num & `MASK_32  ) ? 5: 
                    (num & `MASK_64  ) ? 6: 
                    (num & `MASK_128 ) ? 7: 
                           `MASK_BEDA     ;*/
