module fifo(din, write_en, read_en, dout, empty, full,clk,rst);

//Depth and width for a 8x8 FIFO register
parameter data_width = 8;
parameter depth = 8;
parameter address_lines =3;

//To count number of words in FIFO and return empty and full accordingly
integer count;
integer i;


//To point address in the FIFO
reg [address_lines-1:0]wptr;
reg [address_lines-1:0]rptr;

//Internal FIFO memory
reg [data_width-1:0]mem[0:depth-1];

input clk,rst,write_en,read_en;
input [data_width-1:0]din;
output reg [data_width-1:0]dout;
output reg empty,full;



always@(posedge clk)
	begin
		if(!rst)
			
			begin
			count = 0;
			empty = 1;
			full = 0;
			rptr =0;
			wptr=0;
			dout = 8'd0;
			for(i=0; i<depth;i=i+1)
					mem[i]= 8'd0;
			end
			
		else
			
			begin
			if(write_en)
				begin
				if(full)
				$display($time,"FIFO is full. Can't write further.");
				else
				begin
				mem[wptr]=din;
				empty =0;
				 if(wptr==3'd7)
				  wptr=0;
				  else
				 begin 
				  wptr=wptr+1;
				  count=count+1;
				 end
				 if(count==4'd8)
				 full=1;
				end
				end
			if(read_en)
				begin
				if(empty)
				$display($time,"FIFO is empty. Can't read further.");
				else
				begin
				dout=mem[rptr];
				full=0;
				if(rptr==3'd7)
				 rptr=0;
				else
				begin rptr=rptr+1;
					  count= count-1;
				end
				if(!count)
				empty =1;
				end
				end
			end
	end
	
endmodule
				
				
			
				 
			




