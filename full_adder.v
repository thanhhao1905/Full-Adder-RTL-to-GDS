module full_adder (
input wire a,
input wire b,
input wire c,
output wire sum, 
output wire carry
);

wire sum0;
wire cout0;
wire sum1;
wire cout1;

half_adder ha1 ( .a_in(a),.b_in(b),.sum_out(sum0),.carry_out(cout0));
half_adder ha2 ( .a_in(sum0),.b_in(c),.sum_out(sum1),.carry_out(cout1));

assign sum = sum1;
assign carry = cout1 | cout0;

endmodule
