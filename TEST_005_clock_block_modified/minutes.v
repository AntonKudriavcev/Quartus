module minutes (input    wire   [5:0]    sec,
                input    wire            reset,
                input    wire            clk,
                output   reg    [5:0]    out
);

reg [5:0] prev_sec = 0;

initial begin
  out <= 6'b0;
end

always @(posedge clk) begin
	prev_sec <= sec;	
end

always @(posedge clk) begin
  if (reset) begin
    out <= 6'b0;
  end else begin
  if (prev_sec != sec) begin
    if (sec == 0) begin 	
      if (out == 59) begin
			out <= 6'b0;
      end else begin
			out <= out + 1;
		end
    end
	end 
  end
end

endmodule
      
 
