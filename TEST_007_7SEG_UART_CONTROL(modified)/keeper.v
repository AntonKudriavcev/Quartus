module keeper(
              input  wire       reset,
              input  wire [3:0] b_clk,
              input  wire       clk,
              input  wire       Rx,
              output reg  [7:0] out
); 
reg [3:0] prev_b_clk = 0;
reg [7:0] data       = 0;

always @(posedge clk) begin
  prev_b_clk <= b_clk;
  if (reset) begin
    out  <= 0;
    data <= 0;
  end else begin
	if (prev_b_clk != b_clk) begin
		data[prev_b_clk] <= Rx;     // zapolnyaem registr s nulevigo razriada
		if (prev_b_clk == 8) begin  
			out        <= data;		 // posle zapolnenia otpravliaem na vihod
			prev_b_clk <= 0; 
		end
	end
  end 
end 
 
endmodule 