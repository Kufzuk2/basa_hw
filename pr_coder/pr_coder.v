module pr_coder
#(
    parameter NUM_SIZE = 8,
    parameter OUT_SIZE = $clog2(NUM_SIZE)
)
(
    input  [NUM_SIZE - 1: 0] num,
    output [OUT_SIZE - 1: 0] out
);
    wire [OUT_SIZE - 1: 0] tmp [NUM_SIZE: 0];


    generate
        genvar i;
        for (i = NUM_SIZE; i >= 0; i = i - 1) begin
            if (i == NUM_SIZE)
                assign tmp[i] = 'h0;
            else
                assign tmp[i] = ((tmp[i + 1] == 'h0) & num[i]) ? i : tmp[i + 1];
        end
    endgenerate

    assign out = tmp[0];
endmodule
