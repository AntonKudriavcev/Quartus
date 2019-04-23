module out_sec(      
							input    wire             reset,
							input    wire             clk,
                     input    wire    [5:0]    data,
                     output   reg     [6:0]    out_sec,
                     output   reg     [6:0]    out_dec_sec                    
);

reg [3:0] m = 0;
reg [3:0] l = 0;
reg [5:0] temp_data = 0;

always @(posedge clk) begin
	temp_data <= data;
end

always @(posedge clk) begin
	if(temp_data != data) begin
		if (l < 9) begin
			l <= l + 1;
		end else begin
			l <= 0;
		end	
	end
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
  
	case (m)			
		0: out_dec_sec <= 7'b0000001;  
		1: out_dec_sec <= 7'b1001111; 
		2: out_dec_sec <= 7'b0010010; 
		3: out_dec_sec <= 7'b0000110; 
		4: out_dec_sec <= 7'b1001100; 
		5: out_dec_sec <= 7'b0100100; 
		 						   				
		default 
			out_dec_sec <= 7'b0000001;				 
	endcase
				
  case (l)	
		0:  out_sec <= 7'b0000001;  
		1:  out_sec <= 7'b1001111; 
		2:  out_sec <= 7'b0010010; 
		3:  out_sec <= 7'b0000110; 
		4:  out_sec <= 7'b1001100; 
		5:  out_sec <= 7'b0100100; 
		6:  out_sec <= 7'b0100000;  
		7:  out_sec <= 7'b0001111; 
		8:  out_sec <= 7'b0000000;  
		9:  out_sec <= 7'b0000100;			   				
		default 
		  out_sec   <= 7'b0000001; 
	endcase
end

endmodule