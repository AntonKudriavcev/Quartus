module registr_4bit (
						input		wire			   clk,
						input    wire	[3:0]		data,
						output	reg	[3:0]    out
);

always @(posedge clk) begin
	out <= data;
end 

endmodule