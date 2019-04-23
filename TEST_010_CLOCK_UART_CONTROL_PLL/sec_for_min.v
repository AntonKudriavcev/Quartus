module sec_for_min(
			  input    wire            reconfig_en,
			  input    wire   [9:0]    mil_sec,
           input    wire            reset,
           input    wire            clk,
           output   reg    [5:0]    out
);

reg [9:0] prev_mil_sec = 0;

initial begin
  out <= 6'b0;
end

always @(posedge clk) begin
	prev_mil_sec <= mil_sec;	
end

always @(posedge clk) begin
  if (reset) begin
    out <= 6'b0;
  end else if (reconfig_en) begin
		out <= 6'b000001;
  end else begin
	if (prev_mil_sec != mil_sec) begin
		if (mil_sec == 999) begin
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
      