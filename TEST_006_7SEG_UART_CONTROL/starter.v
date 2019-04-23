module starter (  
						input  wire          reset,
						input  wire 		   data,
						input  wire          clk,
						input  wire  [3:0]   in,
						output reg      		start_bit					
);

initial begin 
	start_bit <= 0;
end

always @(negedge data) begin
	start_bit <= 1;
end	

always @(posedge clk) begin
	if (reset) begin
		start_bit <= 0;
	end	
	else if (in == 8) begin
		start_bit <= 0;
	end	
end

endmodule