module is_even
#(
    parameter NUM_SIZE = 12
)

(
    input  wire [NUM_SIZE - 1: 0] num,
    output wire                   out
);

    assign out = ~num[0];
        
endmodule
