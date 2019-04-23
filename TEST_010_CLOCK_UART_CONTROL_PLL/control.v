module control (
						input   wire          reconfig_en,
						input   wire 			 resett,
						input   wire 			 clk,
						input   wire   [3:0]  key,

						input   wire   [3:0]  min_l,
						input   wire   [3:0]  min_m,
						input   wire   [3:0]  sec_l,
						input   wire   [3:0]  sec_m,
						
						output  reg    [3:0]  out_min_l,
						output  reg    [3:0]  out_min_m,
						output  reg    [3:0]  out_sec_l,
						output  reg    [3:0]  out_sec_m												
);
//------------------------
reg [2:0] state      		= 7;
reg [2:0] count      		= 1;
reg [3:0] prev_key         = 0;
reg 		 prev_reconfig_en = 0;
//-----------------------
reg [3:0] min_m_reg = 0;
reg [3:0] min_l_reg = 0;
reg [3:0] sec_m_reg = 0;
reg [3:0] sec_l_reg = 0;
//------------------------
localparam START    = 6;
localparam SAVE	  = 7;
localparam OUT      = 5;
//---------------------- 
initial begin 
	out_min_m <= 0;
   out_min_l <= 0;
   out_sec_m <= 0;
   out_sec_l <= 0;
end

always @(posedge clk) begin
	prev_reconfig_en <= reconfig_en;
end

always @(posedge clk) begin
	if (resett) begin
		count 	 <= 1;
		state     <= SAVE;
		min_m_reg <= 0;
		min_l_reg <= 0;
		sec_m_reg <= 0;
		sec_l_reg <= 0;	
	end else begin
		if (reconfig_en) begin
			if (prev_reconfig_en != reconfig_en) begin
				state     <= SAVE;
			end
			case (state) // algoritm pri nazatii KEY
				SAVE: begin 
					min_m_reg <= min_m;
					min_l_reg <= min_l;
					sec_m_reg <= sec_m;
					sec_l_reg <= sec_l;
					state     <= START;
				end			
				START: begin // proverka na nazatie
					prev_key <= key;			
					if (prev_key != key) begin
						if (key != 0) begin
							state <= 0;
						end	
					end	
				end
				0: begin	 // opredelenie KEY 
					if (key == 4'b0001) begin // dlia sdviga vlevo 				
						if (count == 4) begin 
							count <= 1;
							state <= START;
						end else begin
							count <= count + 1; // schitaem skol'ko raz sdvinuli
							state <= START;
						end
					end else if (key == 4'b0010) begin // dlia sdviga vpravo					
						if (count == 1) begin 
							count <= 4;
							state <= START;
						end else begin
							count <= count - 1; // schitaem skol'ko raz sdvinuli
							state <= START;
						end
					end else if (key == 4'b0100) begin // dlia + 1
						state <= count;	
					end else if (key == 4'b1000) begin // dlia - 1
						state <= count;
					end
				end				
				1: begin
					if (key == 4'b0100) begin // dlia + 1
						if (sec_l_reg == 9) begin
							sec_l_reg <= 0;
						end else begin 
							sec_l_reg <= sec_l_reg + 1;
						end
						state <= OUT;					
					end else if (key == 4'b1000) begin // dlia - 1	
						if (sec_l_reg == 0) begin
							sec_l_reg <= 9;
						end else begin 
							sec_l_reg <= sec_l_reg - 1;
						end
						state <= OUT;				
					end	
				end			
				2: begin 
					if (key == 4'b0100) begin // dlia + 1
						if (sec_m_reg == 5) begin
							sec_m_reg <= 0;
						end else begin 
							sec_m_reg <= sec_m_reg + 1;
						end
						state <= OUT;
					end else if (key == 4'b1000) begin // dlia - 1	
						if (sec_m_reg == 0) begin
							sec_m_reg <= 5;
						end else begin 
							sec_m_reg <= sec_m_reg - 1;
						end
						state <= OUT;
					end	
				end			
				3: begin 
					if (key == 4'b0100) begin // dlia + 1
						if (min_l_reg == 9) begin
							min_l_reg <= 0;
						end else begin 
							min_l_reg <= min_l_reg + 1;
						end
						state <= OUT;
					end else if (key == 4'b1000) begin // dlia - 1	
						if (min_l_reg == 0) begin
							min_l_reg <= 9;
						end else begin 
							min_l_reg <= min_l_reg - 1;
						end
						state <= OUT;
					end	
				end			
				4: begin 
					if (key == 4'b0100) begin // dlia + 1
						if (min_m_reg == 5) begin
							min_m_reg <= 0;
						end else begin 
							min_m_reg <= min_m_reg + 1;
						end
						state <= OUT;
					end else if (key == 4'b1000) begin	
						if (min_m_reg == 0) begin
							min_m_reg <= 5;
						end else begin 
							min_m_reg <= min_m_reg - 1; // dlia - 1
						end
						state <= OUT;
					end	
				end
				OUT: begin 
					out_min_m <= min_m_reg; // vivodim novie znachenia
				   out_min_l <= min_l_reg; // vivodim novie znachenia
				   out_sec_m <= sec_m_reg; // vivodim novie znachenia
				   out_sec_l <= sec_l_reg;	// vivodim novie znachenia	
					state     <= START;
				end
				default ;
			endcase
		end else begin	
			out_min_m <= min_m; 
			out_min_l <= min_l; 
			out_sec_m <= sec_m; 
			out_sec_l <= sec_l; 
		end	
	end
end 

endmodule	










