module out_m(      
							input    wire             reset,
							input    wire             clk,
							input    wire    [3:0]    data,
							output   reg     [6:0]    out                                      
);

always @(posedge clk) begin
	if (reset) begin
			out <= 1;
	end else begin	   
		case (data)
			0 :  out <= 7'b0000001;
			1 :  out <= 7'b1001111;	  
			2 :  out <= 7'b0010010;	 
			3 :  out <= 7'b0000110;	 
			4 :  out <= 7'b1001100;	 
			5 :  out <= 7'b0100100;	 
			6 :  out <= 7'b0100000;	
			7 :  out <= 7'b0001111;	
			8 :  out <= 7'b0000000;	
			9 :  out <= 7'b0000100;
			10:  out <= 7'b0001000; // A
			11:  out <= 7'b1100000; // b
			12:  out <= 7'b0110001; // C
			13:  out <= 7'b1000010; // d
			14:  out <= 7'b0110000; // E
			15:  out <= 7'b0111000;	// F		 	 						   				
			default 
				  out <= 7'b0000001;				 
		endcase
	end			
end

endmodule