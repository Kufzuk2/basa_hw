module decoder
#(
    parameter N_IN = 2,
    parameter OUT  = 2 ** N_IN
)
(
    input  wire [N_IN - 1: 0] N,
    output wire [OUT  - 1: 0] out
);

    assign out = 'h1 << N;
endmodule


