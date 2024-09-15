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


////
// question: что тут лучше делать с нулем на входе? сделать нумерацию от 1 до 8?
////


module pr_coder
(
    input  [7: 0] num,
    output [2: 0] out
);

    assign out = (num & `MASK_128) ? 3'h7:
                 (num & `MASK_64 ) ? 3'h6:
                 (num & `MASK_32 ) ? 3'h5:
                 (num & `MASK_16 ) ? 3'h4:
                 (num & `MASK_8  ) ? 3'h3:
                 (num & `MASK_4  ) ? 3'h2:
                 (num & `MASK_2  ) ? 3'h1:
                 (num & `MASK_1  ) ? 3'h0:
                               `MASK_BEDA;
endmodule
