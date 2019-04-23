//---------------------------------------
// секундомер
//---------------------------------------
module CLOCK(
	
	input 	wire		   	clk,
	input		wire           reset,
	input    wire           pause, 
	output   reg   [0:6]		secdiv,
	output   reg   [0:6]		sec,
// напортачил с названиями НЕ ОБРАЩАТЬ ВНИМАНИЯ	
	output   reg   [0:6]		min,
	output   reg   [0:6]		decmin

);
// переменные для счета 
	integer  i  =  23'b0;
	integer  j  =  4'b0;	
	integer  k  =  4'b0;
	integer  m  =  4'b0;	
	integer  n  =  4'b0;
	
	

	initial begin
		secdiv  <=  0;
		sec     <=  0;
		min     <=  0;
		decmin  <=  0;
	end

	always @(posedge clk) begin
		if (~reset) begin
			secdiv    <=     1; // чтобы на индикаторе был О
			sec       <=     1; // чтобы на индикаторе был О
			min       <=     1; // чтобы на индикаторе был О
			decmin    <=     1; // чтобы на индикаторе был О
			i         <=     0;
			j         <=     0;
			k         <=     0;
			m         <=     0;
			n         <=     0;
			
			
		end else if (pause) begin
		
		
		end else  begin
			i         <=     i + 1;
			if (i == 5000000) begin // по истечении 0,1 секунды меняем десятые доли секунды
				j  <=   j + 1;
				i  <=   0;
				
				if (j == 9) begin   // по истечении 1 секунды меняем секунды
					j   <=   0;
					k   <=   k + 1;
				end
				
				if (k == 10) begin  // меняем десятки секунд
					k   <=   0;
					m   <=   m + 1;
					end
					
				if (m == 6) begin  // меняем минуты
					m   <=   0;
					n   <=   n + 1;
					end
					
				if (n == 10) begin  // проверка для минут
					n   <=   0;
					end
			end	
//------------------------вывод долей сек--------------------------					
				case (j)
			
				0:  secdiv <= 7'b0000001;  
				1:  secdiv <= 7'b1001111; 
				2:  secdiv <= 7'b0010010; 
				3:  secdiv <= 7'b0000110; 
				4:  secdiv <= 7'b1001100; 
				5:  secdiv <= 7'b0100100; 
				6:  secdiv <= 7'b0100000;  
				7:  secdiv <= 7'b0001111; 
				8:  secdiv <= 7'b0000000;  
				9:  secdiv <= 7'b0000100;			   				
				default 
					 secdiv <= 7'b0000001;
				 
				endcase
//------------------------вывод  сек--------------------------					
			case (k)
			
				0:  sec   <= 7'b0000001;  
				1:  sec   <= 7'b1001111; 
				2:  sec   <= 7'b0010010; 
				3:  sec   <= 7'b0000110; 
				4:  sec   <= 7'b1001100; 
				5:  sec   <= 7'b0100100; 
				6:  sec   <= 7'b0100000;  
				7:  sec   <= 7'b0001111; 
				8:  sec   <= 7'b0000000;  
				9:  sec   <= 7'b0000100;			   				
				default 
					   sec <= 7'b0000001;
				 
				endcase
//------------------------вывод десятков секунд--------------------------				
				case (m)
			
				0:  min   <= 7'b0000001;  
				1:  min   <= 7'b1001111; 
				2:  min 	 <= 7'b0010010; 
				3:  min   <= 7'b0000110; 
				4:  min   <= 7'b1001100; 
				5:  min   <= 7'b0100100; 
				6:  min   <= 7'b0100000;  
				7:  min   <= 7'b0001111; 
				8:  min   <= 7'b0000000;  
				9:  min   <= 7'b0000100;			   				
				default 
					min    <= 7'b0000001;
				 
				endcase
//------------------------вывод  минут--------------------------					
				case (n)
			
				0:  decmin <= 7'b0000001;  
				1:  decmin <= 7'b1001111; 
				2:  decmin <= 7'b0010010; 
				3:  decmin <= 7'b0000110; 
				4:  decmin <= 7'b1001100; 
				5:  decmin <= 7'b0100100; 
				6:  decmin <= 7'b0100000;  
				7:  decmin <= 7'b0001111; 
				8:  decmin <= 7'b0000000;  
				9:  decmin <= 7'b0000100;			   				
				default 
					 decmin <= 7'b0000001;
				 
				endcase		
//------------------------------------------------------------------------	
			
			
		end
	end
	
endmodule			
		