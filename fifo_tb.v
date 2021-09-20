module fifo_tb();

parameter data_width = 8;
parameter depth = 8;
parameter address_lines =3;

reg clk,rst,write_en,read_en;
reg [data_width-1:0]din;
wire empty,full;
wire [data_width-1:0]dout;

fifo DUT(.clk(clk), .rst(rst), .write_en(write_en), .read_en(read_en),
.din(din), .dout(dout), .empty(empty), .full(full));

initial begin
clk=1'b0;
forever #5 clk=~clk;
end

//task for resetting the FIFO
task reset();
begin
@(negedge clk);
rst=0;
@(negedge clk);
rst=1;
end
endtask

//task for writing in FIFO
task write(input [data_width-1:0]data);
 begin
 @(negedge clk);
 write_en=1;
 din=data;
 end
endtask

//task for reading from FIFO
task read();
 begin
 @(negedge clk);
 read_en=1;
 end
endtask

initial
	begin
	reset();
	write(8'b1100_1100);
	write(8'b1001_1000);
	write(8'b1101_1100);
	write(8'b1100_1100);
	write(8'b1111_1100);
	write(8'b0100_1100);
	write(8'b0000_0100);
	write(8'b1100_1101);
	write(8'b1100_1000); //FIFO can't write
	repeat(2) @(negedge clk); 
	write_en=0;
	read();
	repeat(15) @(negedge clk); //FIFO is empty after 8 posedges
	reset();
	//simultaneous read and write
	repeat(10) write({$random});
	write_en=0;
	read();
	#120 $finish;
	end

endmodule
	
	




