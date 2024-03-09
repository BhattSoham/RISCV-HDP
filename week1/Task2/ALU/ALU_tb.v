`timescale 1ns/1ps
module ALU_tb();

reg [3:0] a, b;
reg [2:0]op;
wire [3:0] result; 

ALU uut (
.a(a),
.b(b),
.op(op),
.result(result)
);

initial begin
  $dumpfile("ALU.vcd");
  $dumpvars(1, ALU_tb);

a = 4'b1011; b = 4'b1001; op = 3'b000; #10;
a = 4'b1100; b = 4'b1001; op = 3'b101; #10;
a = 4'b1001; b = 4'b1101; op = 3'b010; #10;
a = 4'b1101; b = 4'b1111; op = 3'b100; #10;
end
endmodule
