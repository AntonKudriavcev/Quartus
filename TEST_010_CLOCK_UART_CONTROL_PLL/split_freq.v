module split_freq(
                  input   wire          reset,
                  input   wire          clk,
                  input   wire          data,
                  output  reg    [3:0]  out
);
//---------------------------
reg [12:0] count     	= 0;
reg [2:0]  state     	= 0;
reg [1:0]  prev_data 	= 0;
reg [1:0]  count_en  	= 0;
//----------------------------
localparam CHECK_START  = 0;
localparam FIRST_BIT    = 1;
localparam COUNT_ENABLE = 2;
localparam NEXT_BITS    = 3;
//----------------------------
initial begin
	out <= 0;
end
//---------schetchik----------	
always @(posedge clk) begin
	if (count_en) begin
		count <= count + 1;
	end else begin
		count <= 0;
	end
end
//-----------------------------
always @(posedge clk) begin
	if (reset) begin
		count_en <= 0;
		out   	<= 0;
		state 	<= CHECK_START;
	end else begin	
		case (state)
			CHECK_START: begin 				 		// proverka na start bit
				prev_data <= data;
				if (prev_data != data)begin 		// smotrim na izmenenie porta dannih
					if (data == 0) begin     		// proverka na stop bit 
						state <= FIRST_BIT;           
					end
				end
			end
			FIRST_BIT: begin              		// esli start bit naiden,					
				if (count == 6249) begin 			// zdem poltora perioda, chtobi okazat'sya v seredine nulevogo informacionnogo bita
					state       <= COUNT_ENABLE;
					out         <= 1;       		// signal o tom, chto seredina nulevogo informacionnogo bita dostignuta
					count_en    <= 0;
				end else begin
					count_en    <= 1;
				end
			end
			COUNT_ENABLE: begin 
				count_en <= 1;
				state    <= NEXT_BITS;
			end	
			NEXT_BITS: begin 							// operacia dlay vseh bitov posle nulevigo					
				if (count == 5207) begin 			// zdem period, chtobi okazat'sya v seredine informacionnogo bita
					if (out == 8) begin   			// kogda obraborali vse biti
						out      <=  0;
						state    <=  CHECK_START;							
						count_en <=  0;
					end else begin
						out      <=  out + 1;		// signal o tom, chto seredina informacionnogo bita dostignuta
						count_en <=  0;
						state    <=  COUNT_ENABLE;
					end                
				end 
			end
			default;								
		endcase	
	end
end

endmodule