module vending_machine ( clk, reset, howManyTicket, origin, destination, money, costOfTicket, moneyToPay, totalMoney );

input clk, reset;
input [2:0] howManyTicket, origin, destination;
input [5:0] money;

output reg [6:0] costOfTicket, moneyToPay, totalMoney;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] now_state;
reg [1:0] next_state;

// reset
always@(posedge clk or negedge reset) begin
  if(reset) now_state = S3;
  else now_state = next_state;
end

always@(now_state or posedge clk ) begin
  case (now_state)
    S0: begin
      if ( destination >= origin )
        costOfTicket = ( destination - origin + 1 ) * 5;
      else
        costOfTicket = ( origin - destination + 1 ) * 5;        
    end
    S1: begin
      moneyToPay = costOfTicket * howManyTicket;              
    end
    S2: begin
        if ( totalMoney > 0 )
          totalMoney = totalMoney + money;
        else
          totalMoney = money;

      $display( "totalMoney =", totalMoney );
      if ( moneyToPay > totalMoney )
        $display( "Still need =", moneyToPay - totalMoney );
    end
    S3: begin
      $display( "Give changes = ", totalMoney - moneyToPay );
      $display( "Tickets = ", howManyTicket );
      costOfTicket = 0;
      moneyToPay = 0; 
      totalMoney = 0;  
    end
  endcase
end

always@(now_state or posedge clk) begin
  case (now_state)
    S0: begin
      if ( origin >= 1 && origin <= 5 && destination >= 1 && destination <= 5 )
        next_state = S1;
      else
        next_state = S0;
    end
    S1: begin
      if ( howManyTicket >= 1 && howManyTicket <= 5 )
        next_state = S2;
      else
        next_state = S1;
    end
    S2: begin
      if ( totalMoney >= moneyToPay )
        next_state = S3;
      else
        next_state = S2;
    end
    S3: begin
      next_state = S0;
    end
    default: next_state = S0;
      
  endcase
end

endmodule
