module oddpipe(clk,opcode_odd,regRA_odd,regRB_odd,regRC_odd,imm_odd,unitType_odd,regRT_addr_odd,regRT_odd,regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,loc_str,flush,regPCin,regPCout,cache_v,cache_block1,cache_block2,cache_block3,cache_block0,cache_tag,cache_load,load,instructions,PC_br);
	
	input clk;
	input load;
	input [31:0]instructions[127:0];
	
	input [10:0] opcode_odd;
	input signed [127:0] regRA_odd,regRB_odd,regRC_odd;
	input signed [15:0] imm_odd;
	input [2:0] unitType_odd;
	input [6:0] regRT_addr_odd;
	
	output logic signed [127:0] regRT_odd;
	output logic [149:0] regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o;
	logic [32:0] regStg_brcomb,regStg_br1,regStg_br2,regStg_br3,regStg_br4;
	logic [31:0] regStg_lsrcomb,regStg_lsr1,regStg_lsr2,regStg_lsr3;
	
	output logic [32768:0][7:0] loc_str;
	output logic flush;
	logic [31:0] regPC_brAddr;
	logic taken;
	logic [31:0] ls_addr;
	
	input [31:0] regPCin;
	output logic [31:0] regPCout;
	output logic [31:0] PC_br;
	logic [31:0] PC_br_comb,PC_br_stg1,PC_br_stg2,PC_br_stg3;
	
	output logic [1:0][0:0] cache_v;
	output logic [1:0] [22:0] cache_tag;
	output logic [127:0][7:0] cache_block0;
	output logic [127:0][7:0] cache_block1;
	output logic [127:0][7:0] cache_block2;
	output logic [127:0][7:0] cache_block3;
	
	output logic cache_load;
	
	logic [31:0] addr=0;
	
	always_comb 
	begin
		if(load==1)
		begin
			for(int i=0;i<50;i++)
			begin
				for(int j=0;j<4;j++)
				begin
					loc_str[addr+3-j]=instructions[i][8*j +: 8];
				end
				addr=addr+4;
			end
		end  
		
		
		case(opcode_odd)
			//Branch Relative
			100:
				begin
					regPC_brAddr= regPCin + ((32'(signed'(imm_odd[15:0]))) << 2);
					taken=1;
				end
				
			//Branch Absolute
			96:
				begin
					regPC_brAddr= 32'(signed'(imm_odd[15:0])) << 2;
					taken=1;
				end
				
			//Branch Relative and Set Link
			102:
				begin
					regPC_brAddr= regPCin + (32'(signed'(imm_odd[15:0])) << 2);
					regRT_odd[127:96]= regPCin + 4;
					regRT_odd[95:0]=0; 
					taken=1;
				end
				
			//Branch Absolute and Set Link
			98:
				begin
					regPC_brAddr= 32'(signed'(imm_odd[15:0])) << 2;
					regRT_odd[127:96]= regPCin + 4;
					regRT_odd[95:0]=0; 
					taken=1;
				end
				
			//Branch Indirect
			424:
				begin
					regPC_brAddr= regRA_odd[127:96] & 32'b11111111111111111111111111111100;
					taken=1;
				end
			
			//Branch If Zero Word
			70:
				begin
					if(regRC_odd[127:96]== 0)
					begin
						regPC_brAddr= (regPCin + (32'(signed'(imm_odd[15:0])) << 2)) & 32'b11111111111111111111111111111100;
						taken=1;
					end
					
					else
					begin
						regPC_brAddr = regPCin + 4;
						taken=0;
					end	
				end
			
			//Branch If Not Zero word
			68:
				begin
					if(regRC_odd[127:96] != 0)
					begin
						regPC_brAddr= (regPCin + (32'(signed'(imm_odd[15:0])) << 2)) & 32'b11111111111111111111111111111100;
						$display(regPC_brAddr);
						taken=1;
					end
					else
					begin
						regPC_brAddr = regPCin + 4;
						taken=0;
					end	
				end
			
			//Branch Indirect If Zero
			296:
				begin
					if(regRC_odd[127:96]== 0)
					begin
						regPC_brAddr= regRA_odd[127:96] & 32'b11111111111111111111111111111100;
						taken=1;
					end
					else
					begin
						regPC_brAddr= regPCin + 4;
						taken=0;
					end	
				end
			
			//Branch Indirect If Not Zero
			297:
				begin
					if(regRC_odd[127:96]!= 0)
					begin
						regPC_brAddr= regRA_odd[127:96] & 32'b11111111111111111111111111111100;
						taken=1;
					end
					else
					begin
						regPC_brAddr = regPCin + 32;
						taken=0;
					end	
				end
			//---------------------------------------- Load/Store Instructions ----------------------------------------
			//Load Quadword (x-form)
			452:
				begin
					ls_addr= (regRA_odd[127:96] + regRB_odd[127:96]) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						regRT_odd[(8*i) +: 8]=loc_str[ls_addr+15-i];
					end
				end
			
			//Load Quadword (a-form)
			97:
				begin
					ls_addr=((32'(signed'(imm_odd[15:0]))) << 2) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						regRT_odd[(8*i) +: 8]=loc_str[ls_addr+15-i];
					end
				end
				
			//Load Quadword Instruction Relative (a-form)	
			103:
				begin
					ls_addr= (regPCin + (32'(signed'(imm_odd[15:0]))) << 2) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						regRT_odd[(8*i) +: 8]=loc_str[ls_addr+15-i];
					end
				end
				
			//Store Quadword (x-form)
			324:
				begin
					ls_addr= (regRA_odd[127:96] + regRB_odd[127:96]) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						loc_str[ls_addr+15-i]=regRC_odd[(8*i) +: 8];
					end
				end
				
			//Store Quadword (a-form)
			65:
				begin
					ls_addr=((32'(signed'(imm_odd[15:0]))) << 2) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						loc_str[ls_addr+15-i]=regRC_odd[(8*i) +: 8];
					end
				end
				
			//Store Quadword Instruction Relative (a-form)
			71:
				begin
					ls_addr= (regPCin + ((32'(signed'(imm_odd[15:0]))) << 2)) & 32'b11111111111111111111111111110000;
					for(int i=0;i<16;i++)
					begin
						loc_str[ls_addr+15-i]=regRC_odd[(8*i) +: 8];
					end
				end  
				
			//----------------------------------------Constant Formation Instructions ----------------------------------------	
			
			//immediate Load Halfword
			131:
				begin
					for(int i=0;i<8;i++)
					begin
						regRT_odd[(16*i) +: 16] = imm_odd[15:0];
					end
				end
			
			//immediate Load Halfword Upper
			130:
				begin
					for(int i=0;i<4;i++)
					begin
						regRT_odd[(32*i) +: 32]= ((32'(signed'(imm_odd[15:0]))) << 16);
					end
				end
				
			//immediate Load Word
			129:
				begin
					for(int i=0;i<4;i++)
					begin
						regRT_odd[(32*i) +: 32]= 32'(signed'(imm_odd[15:0]));
					end
				end
				
			//immediate Or Halfword Lower
			193:
				begin
					//regRT_odd=reg_file[regRT_addr_odd];
					for(int i=0;i<4;i++)
					begin
						regRT_odd[(32*i) +: 32]= {16'b0000000000000000,imm_odd[15:0]} | regRC_odd[(32*i) +: 32];
					end
				end
				
			//---------------------------------------- Permute Instructions ----------------------------------------	
			
			// Shift Left Quadword by Bits
			475 : 
				begin
					int s;
					s = regRB_odd[98:96];
					if(s==0)
						regRT_odd=regRA_odd;
					else	
						regRT_odd=regRA_odd<<s;		
				end
				
			// Shift Left Quadword by Bytes
			479 :
				begin
					int s;	
					s = regRB_odd[100:96];
					if(s==0)	
						regRT_odd=regRA_odd;
					else if(s>15)
						regRT_odd=0;
					else
						regRT_odd=regRA_odd<<(8*s);
				end
			
			// 	Rotate Quadword by Bytes
			476 :
				begin
					int s;
					if(s==0)
						regRT_odd=regRA_odd;
					else
					begin
						regRT_odd[127:0] = (regRA_odd[127:0]<<(s*8)) | (regRA_odd[127:0]>>(128-(s*8)));
					end
				end
				
			// Rotate Quadword by Bits
			472 :
				begin
					int s;
					s = regRB_odd[98:96];
					if(s==0)
						regRT_odd=regRA_odd;
					else
					begin
						regRT_odd[127:0] = (regRA_odd[127:0]<<s) | (regRA_odd[127:0]>>(128-s));
					end
				end
			
			//Gather Bits from Bytes	
			434:
				begin
					for(int j=0;j<16;j++)
					begin
						regRT_odd[96+j]=regRA_odd[8*j];
					end
					
					regRT_odd[127:112]=8'b0;
					regRT_odd[95:0]=0;
				end
				
			//No operation
			513:
				begin
					
				end
			
			//Imiss
			320:
				begin
					if(regPCin[8:7]==0)
					begin
						for(int i=0;i<128;i++)
						begin
							cache_block0[i]=loc_str[regPCin+i];
						end
						cache_v[0]=1;
						cache_tag[0]=regPCin[31:9];
					end
					
					else if(regPCin[8:7]==1)
					begin
						for(int i=0;i<128;i++)
						begin
							cache_block1[i]=loc_str[regPCin+i];
						end
						cache_v[1]=1;
						cache_tag[1]=regPCin[31:9];
					end
					
					else if(regPCin[8:7]==2)
					begin
						for(int i=0;i<128;i++)
						begin
							cache_block2[i]=loc_str[regPCin+i];
						end
						cache_v[2]=1;
						cache_tag[2]=regPCin[31:9];
					end
					
					else if(regPCin[8:7]==3)
					begin
						for(int i=0;i<128;i++)
						begin
							cache_block3[i]=loc_str[regPCin+i];
						end
						cache_v[3]=1;
						cache_tag[3]=regPCin[31:9];
					end 
				end
			
		endcase
					if(unitType_odd==7)
					begin
						regStg_brcomb[31:0]=regPC_brAddr;
						regStg_brcomb[32]=taken;
						PC_br_comb=regPCin;
					end
					else
					begin
						regStg_brcomb='x;
						PC_br_comb='x;
					end
					
					if(opcode_odd==324 || opcode_odd==65 || opcode_odd==71)
					begin
						regStg_lsrcomb=ls_addr;
						
						regStg_oddcomb[149]= 0;
						regStg_oddcomb[148:138]=opcode_odd;
						regStg_oddcomb[137:135]=unitType_odd;
						regStg_oddcomb[134:128]='x;
						regStg_oddcomb[127:0]='x;
					end	
					else
					begin
						regStg_lsrcomb='x;
						
						regStg_oddcomb[149]= 0;
						regStg_oddcomb[148:138]=opcode_odd;
						regStg_oddcomb[137:135]=unitType_odd;
						regStg_oddcomb[134:128]=regRT_addr_odd;
						regStg_oddcomb[127:0]=regRT_odd;
					end

					if(flush==1)
					begin
						loc_str[regStg_lsr1 +: 128]='x;
						loc_str[regStg_lsr2 +: 128]='x;
						loc_str[regStg_lsr3 +: 128]='x;
					end
				
						
	end	
	// stage 1
	always_ff @(posedge clk)
	begin
		if(flush==1)
		begin
			regStg_1o<='x;
			regStg_br1<='x;
		end
		
		else
		begin
			PC_br_stg1<=PC_br_comb;
			regStg_1o<=regStg_oddcomb;
			regStg_br1<=regStg_brcomb;
			regStg_lsr1<=regStg_lsrcomb;
		end	
	end

	// stage 2
	always_ff @(posedge clk)
	begin
		if(flush==1)
		begin
			regStg_2o<='x;
			regStg_br2<='x;
		end
		
		else
		begin
			regStg_2o<=regStg_1o;
			regStg_br2<=regStg_br1;
			regStg_lsr2<=regStg_lsr1;
			PC_br_stg2<=PC_br_stg1;
		end			
	end
	
	// stage 3
	always_ff @(posedge clk)
	begin
		if(flush==1)
		begin
			regStg_3o<='x;
			regStg_br3<='x;
		end
		
		else
		begin
			regStg_3o<=regStg_2o;
			regStg_br3<=regStg_br2;
			regStg_lsr3<=regStg_lsr2;
			PC_br_stg3<=PC_br_stg1;
		end
	end
	
	// stage 4
	always_ff @(posedge clk)
	begin
		if(flush==1)
		begin
			regStg_4o<='x;
			flush<=0;
		end	
		else
		
		begin	
			if(regStg_3o[137:135]==7)
			begin
				if(regStg_br3[32]==1)
				begin
					flush<=1;
					regPCout<=regStg_br3[31:0];
					PC_br<=PC_br_stg3;
				end	
				
				else
					flush<=0;
			end
			
			if(regStg_3o[137:135]==6)
			begin
				regStg_4o[149]<=1;
				regStg_4o[148:0]<=regStg_3o[148:0];
			end
			else
				regStg_4o<=regStg_3o;
		end
	end
	
	// stage 5
	always_ff @(posedge clk)
	begin
		regStg_5o<=regStg_4o;
	end
	
	// stage 6
	always_ff @(posedge clk)
	begin
		if(regStg_5o[137:135]==3)
		begin
			if(regStg_5o[148:138]==320)
				cache_load<=1;
			
			else
				cache_load<=0;
			
			regStg_6o[149]<=1;
			regStg_6o[148:0]<=regStg_5o[148:0];	
		end
		
		else
			begin
			cache_load<=0;
			regStg_6o<=regStg_5o;
			end
	end
	
	// stage 7
	always_ff @(posedge clk)
	begin
		regStg_7o<=regStg_6o;
	end
	

endmodule
