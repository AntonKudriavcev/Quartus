module num_split_m(
                     input    wire    [3:0]    reconfig_l,
							input    wire    [3:0]    reconfig_m,
							input    wire             reconfig_en,
							input    wire             resett,
							input    wire             clk,
                     input    wire    [3:0]    sec_l,
							input    wire    [3:0]    sec_m,					
                     output   reg     [3:0]    l,
                     output   reg     [3:0]    m                    
);
reg [3:0] prev_sec_m = 0;
reg [3:0] prev_l     = 0;

always @(posedge clk) begin 
	prev_sec_m <= sec_m;
	prev_l     <= l;
end

always @(posedge clk) begin
	if (resett) begin 
		l <= 0;
	end else if (reconfig_en) begin
		l <= reconfig_l;	
	end else if (prev_sec_m != sec_m) begin
		if (sec_m == 6) begin
			if (l < 9) begin
				l <= l + 1;
			end else begin
				l <= 0;
			end		
		end
	end
end

always @(posedge clk) begin
	if (resett) begin 
		m <= 0;
	end else if (reconfig_en) begin
		m <= reconfig_m;
	end else if(prev_l != l) begin
		if (m < 6) begin
			if (l == 0) begin
				m <= m + 1;
			end
		end else begin
			m <= 0;
		end
	end
end

endmodule