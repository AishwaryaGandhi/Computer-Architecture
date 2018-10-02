module tb();
 
	logic clk;
		
	logic [127:0][127:0] reg_file;
	logic [32768:0][7:0] loc_str;
	logic [31:0]instructions[127:0];
	logic load;
	logic [31:0] addr=32'b0;
	
	main dut(clk,reg_file,loc_str,load,instructions);

	initial clk = 0;
	always #5 clk = ~clk;
	
	initial begin
	
	$readmemb("bitstream.txt",instructions);	
	
	/* $display(instructions[0]); */
	load=1;
	@(posedge clk)
	load=0;
	
	
	for(int i=0;i<200;i++)
	begin
		@(posedge clk);
	end
	
	$display("local store :  %h",loc_str[2048]);
	$display("local store : %h", loc_str[2049]);
	$display("local store : %h" ,loc_str[2050]);
	$display("local store : %h" ,loc_str[2051]);
	
	$display("local store :  %h",loc_str[2136]);
	$display("local store : %h", loc_str[2137]);
	$display("local store : %h" ,loc_str[2138]);
	$display("local store : %h" ,loc_str[2139]);
	
	$display("local store :  %h",loc_str[2224]);
	$display("local store : %h", loc_str[2225]);
	$display("local store : %h" ,loc_str[2225]);
	$display("local store : %h" ,loc_str[2226]);
	
	$display("local store :  %h",loc_str[2312]);
	$display("local store : %h", loc_str[2312]);
	$display("local store : %h" ,loc_str[2312]);
	$display("local store : %h" ,loc_str[2312]); 
	
	
	$display("Reg 0 : %h",reg_file[0]);
	$display("Reg 1 : %h",reg_file[1]);
	$display("Reg 2 : %h",reg_file[2]);
	$display("Reg 3 : %h",reg_file[3]);
	$display("Reg 4 : %h",reg_file[4]);
	$display("Reg 5 : %h",reg_file[5]);
	$display("Reg 6 : %h",reg_file[6]);
	$display("Reg 7 : %h",reg_file[7]);
	$display("Reg 8 : %h",reg_file[8]);
	$display("Reg 9 : %h",reg_file[9]);
	$display("Reg 10 : %h",reg_file[10]);
	$display("Reg 11 : %h",reg_file[11]);
	$display("Reg 12: %h",reg_file[12]);
	$display("Reg 13 : %h",reg_file[13]);
	$display("Reg 14: %h",reg_file[14]);
	$display("Reg 15 : %h",reg_file[15]);
	$display("Reg 16 : %h",reg_file[16]);
	$display("Reg 17 : %h",reg_file[17]);
	$display("Reg 18: %h",reg_file[18]);
	$display("Reg 19 : %h",reg_file[19]);
	$display("Reg 20: %h",reg_file[20]);
	$display("Reg 21 : %h",reg_file[21]);
	$display("Reg 22 : %h",reg_file[22]);
	$display("Reg 23: %h",reg_file[23]);
	$display("Reg 24 : %h",reg_file[24]);
	$display("Reg 25 : %h",reg_file[25]);
	$display("Reg 26: %h",reg_file[26]);
	$display("Reg 27 : %h",reg_file[27]);
	$display("Reg 28 : %h",reg_file[28]);
	$display("Reg 29: %h",reg_file[29]);
	$display("Reg 30 : %h",reg_file[30]);
	$display("Reg 31 : %h",reg_file[31]);
	$display("Reg 32: %h",reg_file[32]);
	$display("Reg 33 : %h",reg_file[33]);
	$display("Reg 34 : %h",reg_file[34]);
	
	$finish();
	end
endmodule
	