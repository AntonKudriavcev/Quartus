module out_l(      
							input    wire             reset,
							input    wire             clk,
                     input    wire    [3:0]    data,
                     output   reg     [6:0]    out
                                       
);

reg [3:0] temp_data = 0;

always @(posedge clk) begin
	temp_data <= data;
end


always @(posedge clk) begin
	if(temp_data != data) begin
		if (m < 6) begin
			if (l == 9) begin
				m <= m + 1;
			end
		end else begin
			m <= 0;
		end
	end
end

always @(posedge clk) begin  				
  case (l)	
		0:  out <= 7'b0000001;  
		1:  out <= 7'b1001111; 
		2:  out <= 7'b0010010; 
		3:  out <= 7'b0000110; 
		4:  out <= 7'b1001100; 
		5:  out <= 7'b0100100; 
		6:  out <= 7'b0100000;  
		7:  out <= 7'b0001111; 
		8:  out <= 7'b0000000;  
		9:  out <= 7'b0000100;			   				
		default 
		  out   <= 7'b0000001; 
	endcase
end

endmodule