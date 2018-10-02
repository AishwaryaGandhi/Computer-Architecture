module ifetch(clk,regPCout,dec_ready,cache_load,flush,cache_block0,cache_block1,cache_block2,cache_block3,cache_tag,cache_v,instr_1,instr_2,PC_instr_1,PC_instr_2,IF_valid,branch_stall);

	input clk;
	input [31:0] regPCout;
	input dec_ready,cache_load,flush;
		
	//---------- CACHE ----------
	input [1:0][0:0] cache_v;
	input [1:0] [22:0] cache_tag;
	input [127:0][7:0] cache_block0;
	input [127:0][7:0] cache_block1;
	input [127:0][7:0] cache_block2;
	input [127:0][7:0] cache_block3;
	//---------------------------
	
	output logic [31:0] instr_1,instr_2;
	output logic [31:0] PC_instr_1,PC_instr_2;
	output logic IF_valid;
	
	logic miss=0;
	logic [31:0] regPC=32'b0;
	
	input branch_stall;
	
	always_comb
	begin
		// Choose RegPC
		if(flush==1)
		begin
			regPC=regPCout;
		end
		else if(IF_valid==1 && miss==0)
			regPC=regPC+8;
	end
	
	always_ff @(posedge clk)
	begin
		if(dec_ready==1 && branch_stall==0)
		begin
			if(miss==0 || cache_load==1)
			begin
				if(regPC[8:7]==0 && regPC[31:9]==cache_tag[0] && cache_v[0]==1)
				begin
					for(int j=0;j<4;j++)
					begin
						instr_1[8*j +: 8]<=cache_block0[regPC[6:0]+3-j];
						instr_2[8*j +: 8]<=cache_block0[regPC[6:0]+7-j];
					end
					PC_instr_1<=regPC;
					PC_instr_2<=regPC+4;
					IF_valid<=1;
					miss <= 0;
					//regPC<=regPC+8;
				end
				else if(regPC[8:7]==1 && regPC[31:9]==cache_tag[1] && cache_v[0]==1)
				begin
					for(int j=0;j<4;j++)
					begin
						instr_1[8*j +: 8]<=cache_block1[regPC[6:0]+3-j];
						instr_2[8*j +: 8]<=cache_block1[regPC[6:0]+7-j];
					end
					PC_instr_1<=regPC;
					PC_instr_2<=regPC+4;
					IF_valid<=1;
					miss <= 0;
					//regPC<=regPC+8;
				end
				else if(regPC[8:7]==2 && regPC[31:9]==cache_tag[2] && cache_v[0]==1)
				begin
					for(int j=0;j<4;j++)
					begin
						instr_1[8*j +: 8]<=cache_block2[regPC[6:0]+3-j];
						instr_2[8*j +: 8]<=cache_block2[regPC[6:0]+7-j];
					end
					PC_instr_1<=regPC;
					PC_instr_2<=regPC+4;
					IF_valid<=1;
					miss <= 0;
					//regPC<=regPC+8;
				end
				else if(regPC[8:7]==3 && regPC[31:9]==cache_tag[3] && cache_v[0]==1)
				begin
					for(int j=0;j<4;j++)
					begin
						instr_1[8*j +: 8]<=cache_block3[regPC[6:0]+3-j];
						instr_2[8*j +: 8]<=cache_block3[regPC[6:0]+7-j];
					end
					PC_instr_1<=regPC;
					PC_instr_2<=regPC+4;
					IF_valid<=1;
					miss <= 0;
					//regPC<=regPC+8;
				end
				else
				begin
					// imiss 
					instr_1[31:21] <=320; // imiss-odd
					instr_1[20:0]<='x;
					PC_instr_1<=regPC;
					instr_2[31:21]<=1; // no-op even
					instr_2[20:0]<='x;
					//PC_instr_2<=regPC+4;
					IF_valid<=1;
					miss <= 1;
				end
			end
			else if(miss==1)
			begin
				IF_valid <=0;
			end
		end
		else
		begin
			IF_valid <=0;
			//instr_1<=instr_1;
			//instr_2<=instr_2;
		end	
	end
endmodule