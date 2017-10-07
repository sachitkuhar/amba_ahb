module producer (producer_iclk,producer_data);
  
  input producer_iclk;
  output producer_data;
  
  
  wire producer_iclk;
  reg [3:0] producer_data;
 
  
  reg [3:0] i = 4'b0000;
  
  always @ (producer_iclk)
    begin
      producer_data = i;  
      i = (i + 4'b0001);
    end
  initial
    begin
      $monitor("data produced = %b",producer_data);
    end
   

endmodule
