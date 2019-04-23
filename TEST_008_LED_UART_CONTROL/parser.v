module parser(
					input 	wire 		[7:0]		data,
					input    wire 					clk,
					input    wire 					reset,
					output   reg  		[3:0]    out
);
//------------------
reg [2:0] state = 0;
//------------------
localparam ID_KEY = 0;
localparam KEY_0  = 1;
localparam KEY_1  = 2;
localparam KEY_2  = 3;
localparam KEY_3  = 4;
//------------------
initial begin
	out <= 0;
end

always @(posedge clk) begin
	if (reset) begin
		out   	<= 0;
		state 	<= ID_KEY;
	end else begin	
		case (state)
			ID_KEY: begin
				out   	<= 0;
				if (data == 8'hB0) begin
					state <= KEY_0;
				end else if (data == 8'hB1) begin
					state <= KEY_1; 
				end else if (data == 8'hB2) begin
					state <= KEY_2;
				end else if (data == 8'hB3) begin
					state <= KEY_3; 
				end
			end
			KEY_0: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
				end else if (data == 8'hFF) begin
					out <= 4'b0001;
				end else if (data == 8'hAA) begin	
					state <= ID_KEY;
				end
			end
			KEY_1: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
				end else if (data == 8'hFF) begin
					out <= 4'b0010;
				end else if (data == 8'hAA) begin	
					state <= ID_KEY;
				end
			end
			KEY_2: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
				end else if (data == 8'hFF) begin
					out <= 4'b0100;
				end else if (data == 8'hAA) begin	
					state <= ID_KEY;
				end
			end
			KEY_3: begin
				if (data == 8'h00) begin
					out <= 4'b0000;
				end else if (data == 8'hFF) begin
					out <= 4'b1000;
				end else if (data == 8'hAA) begin	
					state <= ID_KEY;
				end
			end
			default ;
		endcase
	end	
end

endmodule