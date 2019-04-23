module parser(
					input 	wire 		[7:0]		data,
					input    wire 					clk,
					input    wire 					reset,
					output   reg  		[3:0]    out,
					output   reg               reconfig_en,
					output   reg               resett
);
//------------------
reg [2:0] state = 0;
//------------------
localparam ID_KEY    = 0;
localparam KEY_0     = 1;
localparam KEY_1     = 2;
localparam KEY_2     = 3;
localparam KEY_3     = 4;
localparam REC_ON    = 5;
localparam REC_OFF   = 6;
localparam RESET_ON  = 7;
localparam RESET_OFF = 8;
//------------------
initial begin
	out    <= 0;
	resett <= 0;
end

always @(posedge clk) begin
	if (reset) begin
		out   	   <= 0;
		state 	   <= ID_KEY;
		reconfig_en <= 0;
	end else begin	
		case (state)
			ID_KEY: begin			
				if (data == 8'hB0) begin
					state <= KEY_0;
				end else if (data == 8'hB1) begin
					state <= KEY_1;
				end else if (data == 8'hB2) begin
					state <= KEY_2;
				end else if (data == 8'hB3) begin
					state <= KEY_3;	
				end else if (data == 8'hAA) begin
					state <= REC_ON;
				end else if (data == 8'hBB) begin
					state <= REC_OFF;
				end else if (data == 8'hCC) begin
					state <= RESET_ON;
				end else if (data == 8'hFF) begin
					state <= RESET_OFF;
				end
			end
			KEY_0: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
					state <= ID_KEY;
				end else if (data == 8'hFF) begin
					out <= 4'b0001;
					state <= ID_KEY;
				end 
			end
			KEY_1: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
					state <= ID_KEY;
				end else if (data == 8'hFF) begin
					out <= 4'b0010;
					state <= ID_KEY;
				end 
			end
			KEY_2: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
					state <= ID_KEY;
				end else if (data == 8'hFF) begin
					out <= 4'b0100;
					state <= ID_KEY;
				end 
			end
			KEY_3: begin
				if (data == 8'h00) begin
					out   <= 4'b0000;
					state <= ID_KEY;
				end else if (data == 8'hFF) begin
					out   <= 4'b1000;
					state <= ID_KEY;
				end 
			end
			REC_ON: begin
				reconfig_en <= 1;
				state       <= ID_KEY;
			end
			REC_OFF: begin
				reconfig_en <= 0;
				state <= ID_KEY;
			end
			RESET_ON: begin
				resett <= 0;
				state  <= ID_KEY;
			end
			RESET_OFF: begin
				resett <= 1;
				state  <= ID_KEY;
			end
			default ;
		endcase
	end	
end

endmodule