`include "producer"
`include "fifo"
`include "consumer"

module top();
  
  
  reg consumer_iclk;
  reg producer_iclk;
  
  
  reg clk;
  
  
  
  
  
  
  always@(posedge clk)
    begin
      #10 assign consumer_iclk = ~consumer_iclk;
      #5 assign producer_iclk = ~producer_iclk;
      
    end
  
  always
    #1 assign clk = ~clk;
  
  
  initial
          #50 $finish;

endmodule