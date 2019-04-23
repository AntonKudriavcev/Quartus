	module sample2(
	input		wire				clk,
	input		wire				reset,
	output	reg   [3:0]		out			
);
  
integer count = 26'b0;
 
initial begin
	out = 0;
	count = 0;
end

always @(posedge clk) begin
	if (reset) begin
		out <= 0;
		count <= 0;
	end else begin
		count <= count + 1;
		if(count == 5) begin
			count <= 0;
			out <= out + 1;
		end
	end
end

endmodule 

		