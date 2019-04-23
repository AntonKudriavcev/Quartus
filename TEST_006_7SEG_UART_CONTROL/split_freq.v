module split_freq(
                  input   wire          reset,
                  input   wire          clk,
                  input   wire          data,
                  output  reg    [3:0]  out

);
reg [1:0]  prev_data = 0;
reg [12:0] count     = 0;
reg [3:0]  j         = 0;
 
initial begin
	out <= 0;
end

always @(posedge clk) begin
	if (reset) begin
		count <= 0;
		out   <= 0;
		j     <= 0;
	end else begin                 // proverka na stop bit    
		prev_data <= data;
		if (prev_data != data)begin // smotrim na izmenenie porta dannih
			if (data == 0) begin     // proverka na stop bit
				j <= j + 1;           
			end
		end
		if (j == 1) begin           // esli stop bit naiden, 
			if (count == 6249) begin // zdem poltora perioda, chtobi okazat'sya v seredine nulevogo informacionnogo bita
				j     <= j + 1;
				out   <= 1;           // signal o tom, chto seredina nulevogo informacionnogo bita dostignuta
				count <= 0;
			end else begin
				count <= count + 1;
			end
		end
//  
		else if (j > 1) begin       // operacia dlay vseh bitov posle nulevigo
			if (count == 5206) begin // zdem period, chtobi okazat'sya v seredine informacionnogo bita
				count <= 0;
				if (out == 8) begin   // kogda schitali vse biti
					out <=  0;
					j   <=  0;
				end else begin
					out <= out + 1;   // signal o tom, chto seredina informacionnogo bita dostignuta
				end                
			end else begin 
				count <= count + 1;
			end
		end
	end
end

endmodule