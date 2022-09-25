# FSM
利用有限狀態機的方法模擬出車站的自動售票販賣機

可以投入零錢種類為1元、5元、10元、50元
 ( 不可同時投入多個硬幣，
       例如: 一次投入2個1元 )
票數的選擇為 1～5張 
車站為 S1、S2 、 S3 、 S4 、 S5 共五站
選站時必須選擇 起點站 與 終點站
當起站與終站相同時 則為 月台票


Main code一律用module vending_machine(…);
總共會有3個always block(參考ilearning紅綠燈的範例)
需要輸出的output有costOfTicket、moneyToPay、totalMoney  //  票價、需付的錢、已付的錢
input有clk、reset、howManyTicket、origin、
destination、money(變數名稱可以不同)
// 多少張票、起始站、終點站、投錢(1元5元10元50元)
宣告的位元如為50，則位元宣告為[5:0]以此
類推


測試數據
module stimulus ;
/***
reg wire clk declare
***
/initial			螢幕輸出(display or monitor)
begin
  #10 money = 10 ;		money 10,	total 10 dollars
  #10 money = 5 ;		money 5,	total 15 dollars	
  #10 money = 1 ;		money 1,	total 16 dollars	
  #10 money = 10 ;		money 10,	total 26 dollars	

  #10 money = 0 ;
  #10 ticket_choose = 2 ;  // 2 = S2	ticket_S2 out
  #10 ticket_choose = 5 ;
			exchange 6 dollars
end
endmodule

