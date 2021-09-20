# Synchronous-FIFO
RTL code with testbench for an 8x8 synchronous FIFO buffer register. 
Simulated in Xilinx ISE and Questa Sim.   
There are two flags empty and full to denote status of the register. 
The memory is overwritten when FIFO becomes full. 
Count variable is used to dive the flags. It keeps a track of the depth used up.
