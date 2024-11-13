module double_dabble 
(
	input  wire [7 : 0] bin,

	output wire [7 : 0] bcd
);


wire [3: 0] right_dig;
wire [3: 0]  left_dig;

assign bcd = {left_dig, right_dig};

wire [3: 0]  left_arr [7: 0];
wire [4: 0] right_arr [7: 0];

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : creating_bcd
        if (i == 0) begin
            assign  left_arr[i] = 0;
            assign right_arr[i] = 0;
        end else if (i < 5) begin
            assign right_arr[i] = right_arr[i - 1] + bin[i - 1] * (4'h1 << (i - 1));
            assign  left_arr[i] = 0;
        end else begin
            assign right_arr[i] = right_arr[i - 1] + 
                                        bin[i - 1] * ((i == 5) ? 6 :
                                                      (i == 6) ? 2 :
                                                                 4); 
            assign left_arr[i] = left_arr[i - 1] +
                                      bin[i - 1] * ((i == 5) ? 1 :
                                                    (i == 6) ? 3 :
                                                               6);
        end

    end

wire [3:0] right1;
wire [4:0] right_init = right_arr[7];
wire [3:0] left_init  = left_arr[7];
assign right1 = right_arr[7] > 4'h9 ? right_arr[7] - 4'ha: right_arr[7];

assign right_dig = (right1 > 4'h9) ? right1 - 4'ha : right1;


wire plus_1 = right_arr[7] > 4'h9;
wire plus_2 = (right_arr[7] > 4'h9) & (right1 > 4'h9);
assign left_dig  = left_arr[7]  + plus_1 + plus_2;

endgenerate


endmodule









