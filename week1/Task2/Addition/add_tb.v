module add_tb();
reg num1, num2, cin;
wire sum, cout;

add uut (
.num1(num1),
.num2(num2),
.cin(cin),
.sum(sum),
.cout(cout)
);

initial begin
 $dumpfile("add.vcd");
 $dumpvars(1, add_tb);

num1 = 0; num2 = 0; cin = 0; #10;
num1 = 0; num2 = 0; cin = 1; #10;
num1 = 0; num2 = 1; cin = 0; #10;
num1 = 0; num2 = 1; cin = 1; #10;
num1 = 1; num2 = 0; cin = 0; #10;
num1 = 1; num2 = 0; cin = 1; #10;
num1 = 0; num2 = 1; cin = 0; #10;
num1 = 1; num2 = 1; cin = 1; #10;

end

endmodule
