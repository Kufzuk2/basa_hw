module is_even
#(
    parameter MAX_NUM_SIZE = 64
)
(
    input  wire     num,
    output wire is_even
)

    assign is_even = ~num[0];
        
endmodule
