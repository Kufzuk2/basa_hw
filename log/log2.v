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

    assign degree = { 3{(`MASK_1 == (num >> 0))}} & 3'h0 |
                    { 3{(`MASK_1 == (num >> 1))}} & 3'h1 |   
                    { 3{(`MASK_1 == (num >> 2))}} & 3'h2 |  
                    { 3{(`MASK_1 == (num >> 3))}} & 3'h3 |  
                    { 3{(`MASK_1 == (num >> 4))}} & 3'h4 |  
                    { 3{(`MASK_1 == (num >> 5))}} & 3'h5 |  
                    { 3{(`MASK_1 == (num >> 6))}} & 3'h6 |  
                    { 3{(`MASK_1 == (num >> 7))}} & 3'h7 ;  
                    // i suppose that there are no other options

endmodule
    

