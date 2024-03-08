module add( 
input num1, num2, cin, 
output sum, cout);

reg [1:0] temp;

always@(*)
   begin
       temp = {1'b0, num1} + {1'b0, num2} + {1'b0, cin};
   end

assign sum = temp[0];
assign cout = temp[1];

endmodule 
