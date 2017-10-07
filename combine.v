module top();
  
  reg consumer_iclk;
  reg producer_iclk;
  
  wire cr;
  wire [3:0] cd;
  wire [3:0] pd;  
  
  reg clk;  
  
  always@(posedge clk)
    begin
      #10 assign consumer_iclk = ~consumer_iclk;
      #5 assign producer_iclk = ~producer_iclk;      
    end
  
  always
    #1 assign clk = ~clk;  
  
  initial
         begin
           /*
		  consumer_iclk = 0;
		  producer_iclk = 0;
		  cr =0;
		  cd=0;
		  pd=0;
  */
   #5000 $finish;
         end
  
  producer p1(
    pd
    );
  
 
  fifo f1(
    cd,
    pd,
    cr
  );
  
  consumer c1(
    cr,
    cd
  );
  
  
  
  
endmodule





//------------------------------
//PRODUCER IS  PRODUCING DATA

module producer (/*producer_iclk,*/producer_data);
  
  //input producer_iclk;
  output producer_data;
  
  
  reg producer_iclk;
  reg [3:0] producer_data;
  
  //assign producer_data = 0;
 
  
  reg [3:0] i = 4'b0000;

  always @(producer_iclk)
    begin
      producer_data = producer_data + 1;
    end
  
  initial
    begin
      producer_data = 0;
      producer_iclk = 0;
      //$monitor("time=%t data produced = %b    clk=%b",$time,producer_data,producer_iclk);
      
      //#100 $finish;
       
           
    end
 
  
//internal 5 unit clk
  
always
  begin
    #5 producer_iclk = ~(producer_iclk);
  end
  
  
  
  
endmodule




//-------------------------------

module fifo(consumer_data,producer_data, consumer_req);
  
  input consumer_req;
  input producer_data;
  output consumer_data;
    
  reg [3:0] consumer_data;
  reg [3:0] producer_data;
  reg consumer_req;
    
  int i;
  int j;
  int last;
  int start;
  int diff;
  int last_s;
  int start_s;
  
  reg [3:0] queue [9:0];
  
  
  initial
    begin
      assign last_s = last % 10;
      assign start_s = start % 10;
      assign diff = last - start;
      //$monitor("producer data = %b %d",producer_data,producer_data);
      //producer_data = 0;
      #30for(j=0;j<10;j++)
        begin
          //$display("queue[%d] =%d at time =%t",j,queue[j],$time);
        end
      
    end
  
 //add_data thingy 
  always @ (producer_data)
    if((diff < 10))
      begin
    begin      
      queue[last_s] = producer_data;
      //$display("add queue[%d] is %d",last_s,queue[last_s]);
      #0 last = last +1;      
    end
      end else begin
        $finish;
      end
  
  //pop data thingy
  always @(consumer_req)
    begin
      if(consumer_req == 1)
        begin
          if(diff != 0)
            begin
             // $display("pop queue[%d] = %d",start_s,queue[start_s]);
              consumer_data = queue[start_s];
          //$display("consumer data = %d",consumer_data);
          #0 start = start +1;
            end
          
          
          /*
          queue[start] = consumer_data;
          #0 start = start + 1;
          $display("start = %d at time = %t",start,$time);
          $display("consumer data = %d",consumer_data);
          */
        end
    end
  

endmodule
//------------------------
module consumer(/*consumer_iclk,*/consumer_req,consumer_data);


  
  //input consumer_iclk;
  input consumer_data;
  output consumer_req;
  
  reg consumer_iclk;
  reg [3:0] consumer_data;
  reg consumer_req;
  
  //  consumer_req = 0;
  
  always @(consumer_iclk)
    begin
  		consumer_req = 1;
      #1 consumer_req = 0;
    end
  
    
  initial
    begin
	//consumer_data = 0;
	consumer_req=0;
	consumer_iclk =1;
      $monitor("data consumed : %d at time = %t", consumer_data,$time);
  
    //#20 $finish;
    end
  //internal clk
  
      always
    begin
      #10 consumer_iclk = ~consumer_iclk;
    end
  
 
  
  
endmodule
