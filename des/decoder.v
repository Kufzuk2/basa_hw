module decoder
(
    input  wire [2: 0] N,
    output wire [7: 0] out
);

    assign out = 8'h1 << N;
endmodule


