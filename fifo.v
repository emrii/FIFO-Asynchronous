module fifo #(parameter DEPTH = 5, WIDTH = 8, PTR_W = 3)
   (output [WIDTH-1:0] reg data_out,
    output reg 	           isFull, isEmpty
    input  [WIDTH-1:0]     data_in,
    input 	           isValid, clkA, clkB, reset);

   reg [WIDTH-1:0] 	   mem [DEPTH-1:0];
   reg [PTR_W-1:0] 	   rd_ptr, wr_ptr ;
      
   //write
   always @ (posedge clkA or posedge reset) begin
      if (reset) begin
	 wr_ptr <= 3'b000;
      end else if (isValid) begin
	 mem[wr_ptr] <= data_in;
	 wr_ptr <= wr_ptr + 1;
      end
   end

   //read
   always @ (posedge clkB or posedge reset) begin
      if (reset) begin
	 rd_ptr <= 3'b000;
      end else begin
	 data_out <= mem[rd_ptr];
	 rd_ptr <= rd_ptr + 1;
      end
   end

   //checks
   always @ (rd_ptr, wr_ptr) begin
      if (reset) begin
	 isFull <= 0;
	 isEmpty <= 1;
      end else begin
	 if (rd_ptr == wr_ptr + 1)
	   isFull <= 1;
	 else if (wr_ptr == rd_ptr + 1)
	   isEmpty <= 1;
	 else begin
	    isFull <= 0;
	    isEmpty <= 0;
	 end
      end // else: !if(reset)

   end // always @ (rd_ptr, wr_ptr)

   //add functionality for circular mem location in the pointers (altho, verilog will automatically cast to 3 bit only on overflow)

endmodule // fifo

      
	 
	
      
	 
	

   
    
						 
