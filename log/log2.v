`define MASK_1    8'h1 

module log2
#(
    parameter SIZE_IN  = 8,
    parameter SIZE_OUT = $clog2(SIZE_IN)
)

(
    input  wire [SIZE_IN  - 1: 0]    num,
    output wire [SIZE_OUT - 1: 0] degree
);
    wire [SIZE_OUT - 1: 0] tmp [SIZE_IN: 0];
   

    generate 
        genvar i;
        for (i = 0; i < SIZE_IN + 1; i = i + 1) begin
            if (i == 0)
                assign tmp[i] = 'h0;
            else
                assign tmp[i] = tmp[i - 1] | ({SIZE_OUT{(`MASK_1 == (num >> i))}} & i);
        end
    endgenerate

    assign degree = tmp[SIZE_IN];
endmodule
    
