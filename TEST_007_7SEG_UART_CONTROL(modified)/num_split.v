module num_split( 
						input    wire             reset,
						input    wire             clk,
						input    wire    [7:0]    data,
						output   reg     [3:0]    l,
						output   reg     [3:0]    m                    
);

reg [7:0] temp_data = 0;

always @(posedge clk) begin 
	temp_data <= data;
end
// videlenie mladshego polubaita 
always @(posedge clk) begin
	if (reset) begin 
		l <= 0;
	end else if(temp_data != data) begin
		l <= data[3:0];		
	end
end
// videlenie starshego polubaita 
always @(posedge clk) begin
	if (reset) begin 
		m <= 0;
	end else if(temp_data != data) begin
		m <= data[7:4];
	end
end

endmodule