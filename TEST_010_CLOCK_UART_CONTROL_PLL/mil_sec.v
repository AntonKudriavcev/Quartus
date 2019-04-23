//------------------
// 
//-----------------
module mil_sec(
					input      wire                reconfig_en,
					input      wire                clk,
					input      wire                resett,
					output     reg     [9:0]       out 
);

 // 
reg[15:0] count_clk = 16'b0; // 


initial begin
  out <= 10'b0;
end

always @(posedge clk) begin
	if (resett) begin   
    count_clk <= 16'b0;
	end else if (reconfig_en) begin
		count_clk <= 0;
		out       <= 10'b0;
   end else begin    
     if (count_clk == 49_999) begin
       count_clk <= 16'b0; 
       if (out == 999) begin
			 out <= 10'b0;
       end else begin
			 out <= out + 1;
		 end	
     end else begin
		 count_clk <= count_clk + 1;
	  end
   end  
end 

endmodule   




        
        
        
        
        
        