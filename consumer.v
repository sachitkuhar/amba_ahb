module consumer(consumer_iclk,consumer_req,consumer_data);


  
  input consumer_iclk;
  input consumer_data;
  output consumer_req;
  
  wire consumer_iclk;
  wire [3:0] consumer_data;
  reg consumer_req;
  
  //  consumer_req = 0;
  
  always @( consumer_iclk)
    begin
  		consumer_req = 1;
      #1 consumer_req = 0;
    end
  
    
  initial
    $monitor("data consumed : %b", consumer_data);
  
endmodule