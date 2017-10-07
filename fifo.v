module fifo( consumer_data, consumer_req, producer_data);
  
  
  //inout and output types of data that will be used
  input consumer_req;
  output consumer_data;
  input producer_data;
  
  //data types of variables that will be used
  wire [3:0] producer_data;
  wire consumer_req;
  reg consumer_data;
  
  
  //internal variables that will be used
  reg [3:0] stack [0:9];
  int start = 0;
  int last = 0;
    
  //these will make sure that the real integer doesnt blow above 10, i.e. max limit of the array
  int start_s; 
  int last_s;
  
  
  
  
  initial
  begin
  last = 0;
  start = 0;
  assign last_s = (last%10);
  assign start_s = (start%10);
  end
  

task add_data;
begin
stack[last] = producer_data;

assign last = last +1 ;
end
endtask

task pop_data;
begin
start = start +1;
consumer_data = stack[start];
end
endtask

task check_empty;
begin
if((last - start)==1)
begin
consumer_data = 0;
end
 else
begin
pop_data;
end
end
endtask

task check_full;
begin
if((last-start) == 9)
begin
$finish;
end else begin
add_data;
end
endtask

always @(consumer_req)
begin
check_empty;
end

always@(producer_data)
begin
check_full;
end

  
  
  
      
endmodule