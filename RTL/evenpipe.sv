module evenpipe(clk,opcode_even,regRA_even, regRB_even, regRC_even,imm_even,unitType_even,regRT_addr_even,regRT_even,regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,flush,reg_file,priority_reg);
	input clk;
	input [10:0] opcode_even;
	input signed [127:0] regRA_even, regRB_even, regRC_even;
	input signed [15:0] imm_even;
	input [2:0] unitType_even;
	input [6:0] regRT_addr_even;
	input flush;
	input [127:0][127:0] reg_file;
	
	input priority_reg;
	
	logic pr_stg1,pr_stg2,pr_stg3;
	
	output logic signed [127:0] regRT_even;
	output logic [149:0] regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e;

	logic signed [32:0] temp33;
		
	// Even Case Stage
	always_comb
	begin
		case (opcode_even)
		
		//---------------------------------------- Integer & Logical Instructions ----------------------------------------
		
		// Add Halfword
		200 :
			begin
				regRT_even[127:112]=regRA_even[127:112] + regRB_even[127:112];
				regRT_even[111:96]=regRA_even[111:96] + regRB_even[111:96];
				regRT_even[95:80]=regRA_even[95:80] + regRB_even[95:80];
				regRT_even[79:64]=regRA_even[79:64] + regRB_even[79:64];
				regRT_even[63:48]=regRA_even[63:48] + regRB_even[63:48];
				regRT_even[47:32]=regRA_even[47:32] + regRB_even[47:32];
				regRT_even[31:16]=regRA_even[31:16] + regRB_even[31:16];
				regRT_even[15:0]=regRA_even[15:0] + regRB_even[15:0];
								
			end
			
		//Add Halfword Imm
		29: begin	
				regRT_even[127:112]=regRA_even[127:112] + 16'(signed'(imm_even[9:0]));
				regRT_even[111:96]=regRA_even[111:96] + 16'(signed'(imm_even[9:0]));
				regRT_even[95:80]=regRA_even[95:80] + 16'(signed'(imm_even[9:0]));
				regRT_even[79:64]=regRA_even[79:64] + 16'(signed'(imm_even[9:0]));
				regRT_even[63:48]=regRA_even[63:48] + 16'(signed'(imm_even[9:0]));
				regRT_even[47:32]=regRA_even[47:32] + 16'(signed'(imm_even[9:0]));
				regRT_even[31:16]=regRA_even[31:16] + 16'(signed'(imm_even[9:0]));
				regRT_even[15:0]=regRA_even[15:0]+ 16'(signed'(imm_even[9:0]));			
			end
			
		//Add Word
		192 : 
			begin
				regRT_even[127:96]=regRA_even[127:96] + regRB_even[127:96];
				regRT_even[95:64]=regRA_even[95:64] + regRB_even[95:64];
				regRT_even[63:32]=regRA_even[63:32] + regRB_even[63:32];
				regRT_even[31:0]=regRA_even[31:0] + regRB_even[31:0];
			end
		
		// Add Word Imm
		28 :
			begin	
				regRT_even[127:96]=regRA_even[127:96]+ 32'(signed'(imm_even[9:0]));
				regRT_even[95:64]=regRA_even[95:64] + 32'(signed'(imm_even[9:0]));
				regRT_even[63:32]=regRA_even[63:32] + 32'(signed'(imm_even[9:0]));
				regRT_even[31:0]=regRA_even[31:0] + 32'(signed'(imm_even[9:0]));
			end
			
			
		// Subtract from Word
		64 :
			begin
				regRT_even[127:96]=regRB_even[127:96] - regRA_even[127:96];
				regRT_even[95:64]=regRB_even[95:64] - regRA_even[95:64];
				regRT_even[63:32]=regRB_even[63:32] - regRA_even[63:32];
				regRT_even[31:0]=regRB_even[31:0] - regRA_even[31:0];
			end
		
		///Subtract from Word Immediate
		13:
			begin
				regRT_even[127:96]= regRA_even[127:96]-32'(signed'(imm_even[9:0]));
				regRT_even[95:64]= regRA_even[95:64]-32'(signed'(imm_even[9:0]));
				regRT_even[63:32]= regRA_even[63:32]-32'(signed'(imm_even[9:0]));
				regRT_even[31:0]= regRA_even[31:0]-32'(signed'(imm_even[9:0]));
			end
			
		// Add Extended
		832 :
			begin
				regRT_even[127:96]=regRA_even[127:96] + regRB_even[127:96] + regRC_even[96];
				regRT_even[95:64]=regRA_even[95:64] + regRB_even[95:64] + regRC_even[64];
				regRT_even[63:32]=regRA_even[63:32] + regRB_even[63:32] + regRC_even[32];
				regRT_even[31:0]=regRA_even[31:0] + regRB_even[31:0] + regRC_even[0];
			end
			
		// Carry Generate
		194 :
			begin
				temp33=regRA_even[127:96] + regRB_even[127:96];
				regRT_even[96]=temp33[32];
				regRT_even[127:97]=0;
				
				temp33=regRA_even[95:64] + regRB_even[95:64];
				regRT_even[64]=temp33[32];
				regRT_even[95:65]=0;
				
				temp33=regRA_even[63:32] + regRB_even[63:32];
				regRT_even[32]=temp33[32];
				regRT_even[63:33]=0;
				
				temp33=regRA_even[31:0] + regRB_even[31:0];
				regRT_even[0]=temp33[32];
				regRT_even[31:1]=0;
				
			end

		// Subtract Extended		
		833 :
			begin
				//regRT_even=reg_file[regRT_addr_even];
				regRT_even[127:96]=(regRB_even[127:96] - regRA_even[127:96]) - (regRC_even[96]? 0 : 1) ;
				regRT_even[95:64]=(regRB_even[95:64] - regRA_even[95:64]) - (regRC_even[64]? 0 : 1);
				regRT_even[63:32]=(regRB_even[63:32] - regRA_even[63:32]) - (regRC_even[32]? 0 : 1);
				regRT_even[31:0]=(regRB_even[31:0] - regRA_even[31:0]) - (regRC_even[0]? 0 : 1);
			end
			
		// Borrow Generate
		66 :
			begin
				for(int i=0;i<4;i++)
				begin
					if(regRB_even[(32*i) +: 31] < regRA_even[(32*i) +: 31])
						regRT_even[(32*i) +: 31]=0;
						
					else
						regRT_even[(32*i) +: 31]=1;							
				end
			
			end
			
		//multiply
			964: 
				begin
					regRT_even[127:96]= regRA_even[111:96] * regRB_even[111:96];
					regRT_even[95:64]= regRA_even[79:64] * regRB_even[79:64];
					regRT_even[63:32]= regRA_even[47:32] * regRB_even[47:32];
					regRT_even[31:0]= regRA_even[15:0] * regRB_even[15:0];
				end
			
		//Multiply and Add
		12:
			begin
				regRT_even[127:96]= regRA_even[111:96] * regRB_even[111:96] + regRC_even[127:96];
				regRT_even[95:64]= regRA_even[79:64] * regRB_even[79:64] + regRC_even[103:64];
				regRT_even[63:32]= regRA_even[47:32] * regRB_even[47:32]+ regRC_even[63:32];
				regRT_even[31:0]= regRA_even[15:0] * regRB_even[15:0]+ regRC_even[31:0] ;
			end

		//Multiply high
		965: 
			begin
				regRT_even[127:96]= regRA_even[127:112] * regRB_even[111:96];
				regRT_even[127:112]=regRT_even[111:96];
				regRT_even[111:96]=0;
				
				regRT_even[95:64]= regRA_even[95:80] * regRB_even[79:64];
				regRT_even[95:80]=regRT_even[79:64];
				regRT_even[79:64]=0;
				
				regRT_even[63:32]= regRA_even[63:48] * regRB_even[47:32];
				regRT_even[63:48]=regRT_even[47:32];
				regRT_even[47:32]=0;
				
				regRT_even[31:0]= regRA_even[31:16] * regRB_even[15:0];
				regRT_even[31:16]=regRT_even[15:0];
				regRT_even[15:0]=0;
				
			end
		//Multiply and Shift Right	
		967:
			begin
				regRT_even[127:96]= regRA_even[111:96] * regRB_even[111:96];
				regRT_even[111:96]=regRT_even[127:112];
				regRT_even[127:96]=32'(signed'(regRT_even[111:96]));
				
				regRT_even[95:64]=regRA_even[79:64] * regRB_even[79:64];
				regRT_even[79:64]=regRT_even[95:80];
				regRT_even[95:64]=32'(signed'(regRT_even[79:64]));
				
				regRT_even[63:32]= regRA_even[47:32] * regRB_even[47:32];
				regRT_even[47:32]=regRT_even[63:48];
				regRT_even[63:32]=32'(signed'(regRT_even[47:32]));
				
				regRT_even[31:0]= regRA_even[15:0] * regRB_even[15:0];
				regRT_even[15:0]=regRT_even[31:16];
				regRT_even[31:0]=32'(signed'(regRT_even[15:0]));
			end
		
		//Multiply High High
		966:
			begin
				regRT_even[127:96]= regRA_even[127:112] * regRB_even[127:112];
				regRT_even[95:64]= regRA_even[95:80] * regRB_even[95:80];
				regRT_even[63:32]= regRA_even[63:48] * regRB_even[63:48];
				regRT_even[31:0]= regRA_even[31:16] * regRB_even[31:16];
			end
			
		//Count Leading Zeros
		677:
			begin
				for(int j=0;j<4;j++)
				begin
					int count;
					count=0;
					for(int i=(32*j)+31 ; i>=32*j; i--)
					begin
						if(regRA_even[i]==1)
						break;
			
						else
						count=count+1;
					end
					regRT_even[(32*j) +: 32]=count;
					//regRT_even[32j+31:32j]=count;
				end
				
			end
		
		//Count Ones in Bytes
		692:
			begin
				for(int j=0;j<16;j++)
				begin
					int count;
					count=0;
					for(int i=8*j;i<=7+(8*j);i++)
					begin
						if(regRA_even[i]==1)
						count=count+1;
					end
					regRT_even[(8*j) +: 8]=count;
					//regRT_even[7+(8*j):(8*j)]=count;
				end
			end
			
		//Form Select Mask for Bytes	
		438:	
			begin
				int i,j;
				for(j=0; j<16; j++)
				begin
					if(regRA_even[96+j]==0)
					regRT_even[(8*j) +: 8]=8'b00000000;
					
					else
					regRT_even[(8*j) +: 8]=8'b11111111;
				end
			end

		//Form Select Mask for Bytes Immediate
		101:
			begin
				int j;
				for(j=0; j<16; j++)
				begin
					if(imm_even[j]==0)
					regRT_even[(8*j) +: 8]=8'b00000000;
				
					else
					regRT_even[(8*j) +: 8]=8'b11111111;
				end
			end
			
		//Absolute Differences of Bytes	
		83:
			begin
				for(int j=0;j<16;j++)
				begin
					if(regRA_even[(8*j) +: 8] > regRB_even[(8*j) +: 8])
						regRT_even[(8*j) +: 8]=regRA_even[(8*j) +: 8]-regRB_even[(8*j) +: 8];
					
					else
						regRT_even[(8*j) +: 8]=regRB_even[(8*j) +: 8]-regRA_even[(8*j) +: 8];
				end
			end
			
		//Sum Bytes into Halfwords
		595:
			begin
				regRT_even[127:112]=regRB_even[103:96]+regRB_even[111:104]+regRB_even[119:112]+regRB_even[127:120];
				regRT_even[111:96]=regRA_even[103:96]+regRA_even[111:104]+regRA_even[119:112]+regRA_even[127:120];
				
				regRT_even[95:80]=regRB_even[95:88]+regRB_even[87:80]+regRB_even[79:72]+regRB_even[71:64];
				regRT_even[79:64]=regRA_even[95:88]+regRA_even[87:80]+regRA_even[79:72]+regRA_even[71:64];
				
				regRT_even[63:48]=regRB_even[63:56]+regRB_even[55:48]+regRB_even[47:40]+regRB_even[39:32];
				regRT_even[47:32]=regRA_even[63:56]+regRA_even[55:48]+regRA_even[47:40]+regRA_even[39:32];
				
				regRT_even[31:16]=regRB_even[31:24]+regRB_even[23:16]+regRB_even[15:8]+regRB_even[7:0];
				regRT_even[15:0]=regRA_even[31:24]+regRA_even[23:16]+regRA_even[15:8]+regRA_even[7:0];
			end
			
		//Average Bytes
		211:
			begin
				for(int j=0;j<16;j++)
				begin
					regRT_even[(8*j) +: 8]=regRA_even[(8*j) +: 8]+regRB_even[(8*j) +: 8]+1;
					regRT_even[(8*j) +: 8]= regRT_even[(8*j) +: 8]>>1;
				end
			end
		
		//Extend Sign Halfword to Word
		686:
			begin
				regRT_even[127:96]= 32'(signed'(regRA_even[111:96]));
				regRT_even[95:64]= 32'(signed'(regRA_even[79:64]));
				regRT_even[63:32]= 32'(signed'(regRA_even[47:32]));
				regRT_even[31:0]= 32'(signed'(regRA_even[15:0]));
			end
			
		//And
		705:
			begin
				regRT_even[127:96]= regRA_even[127:96] & regRB_even[127:96];
				regRT_even[95:64]= regRA_even[95:64] & regRB_even[95:64];
				regRT_even[63:32]= regRA_even[63:32] & regRB_even[63:32];
				regRT_even[31:0]= regRA_even[31:0] & regRB_even[31:0];
			end
			
		//And Word Immediate
		20:
			begin
				regRT_even[127:96]= regRA_even[127:96] & 32'(signed'(imm_even[9:0]));
				regRT_even[95:64]= regRA_even[95:64] & 32'(signed'(imm_even[9:0]));
				regRT_even[63:32]= regRA_even[63:32] & 32'(signed'(imm_even[9:0]));
				regRT_even[31:0]= regRA_even[31:0] & 32'(signed'(imm_even[9:0]));
			end
			
		//OR
		713:
			begin
				regRT_even[127:96]= regRA_even[127:96] | regRB_even[127:96];
				regRT_even[95:64]= regRA_even[95:64] | regRB_even[95:64];
				regRT_even[63:32]= regRA_even[63:32] | regRB_even[63:32];
				regRT_even[31:0]= regRA_even[31:0] | regRB_even[31:0];
			end

		//Or Word Immediate	
		4:
			begin
				regRT_even[127:96]= regRA_even[127:96] | 32'(signed'(imm_even[9:0]));
				regRT_even[95:64]= regRA_even[95:64] | 32'(signed'(imm_even[9:0]));
				regRT_even[63:32]= regRA_even[63:32] | 32'(signed'(imm_even[9:0]));
				regRT_even[31:0]= regRA_even[31:0] | 32'(signed'(imm_even[9:0]));
			end	
			
		//Exclusive Or
		577:
			begin
				regRT_even[127:96]= regRA_even[127:96] ^ regRB_even[127:96];
				regRT_even[95:64]= regRA_even[95:64] ^ regRB_even[95:64];
				regRT_even[63:32]= regRA_even[63:32] ^ regRB_even[63:32];
				regRT_even[31:0]= regRA_even[31:0] ^ regRB_even[31:0];
			end
			
		//Nand	
		201:
			begin
				regRT_even[127:96]= ~(regRA_even[127:96] & regRB_even[127:96]);
				regRT_even[95:64]= ~(regRA_even[95:64] & regRB_even[95:64]);
				regRT_even[63:32]= ~(regRA_even[63:32] & regRB_even[63:32]);
				regRT_even[31:0]= ~(regRA_even[31:0] & regRB_even[31:0]);
			end
			
		//Select bits	
		8:
			begin
				regRT_even= (regRC_even & regRB_even) | ((~regRC_even) & regRA_even) ;
			end		

		//---------------------------------------- Shift & Rotate Instructions ----------------------------------------
		
		// Shift Left Halfword
		95 : 
			begin
				int s;
				for(int i=0;i<8;i++)
				begin
					s = regRB_even[(16*i) +: 16] & 31; 
					if(s==0)
						regRT_even[(16*i) +: 16] = regRA_even[(16*i) +: 16];
					else if (s>15)
						regRT_even[(16*i) +: 16]=0;
					else
						regRT_even[(16*i) +: 16]=regRA_even[(16*i) +: 16]<<s;
				end
			end
			
		// Shift Left Word		
		91 :
			begin
				int s;
				for(int i=0;i<4;i++)
				begin
					s = regRB_even[(32*i) +: 32] & 63;
					if(s==0)
						regRT_even[(32*i) +: 32] = regRA_even[(32*i) +: 32];
					else if (s>31)
						regRT_even[(32*i) +: 32]=0;
					else
						regRT_even[(32*i) +: 32]=regRA_even[(32*i) +: 32]<<s;
				end	
			end
						
		// Rotate Halfword
		92 :
			begin
				logic [3:0] s;
				bit[15:0] temp;
				for(int i=0;i<8;i++)
				begin
					s = regRB_even[(16*i) +: 16]& 31;
					$display("%d s",s);
					if(s==0)
						regRT_even[(16*i) +: 16] = regRA_even[(16*i) +: 16];
					else
					begin
						regRT_even[(16*i) +: 16] = (regRA_even[(16*i) +: 16]<<s) | (regRA_even[(16*i) +: 16]>>(~s+1'b1));
						
					end		
				end
			end
					
		//---------------------------------------- Floating Point Instructions ----------------------------------------	
		
		//Double Floating Add
		716:
			begin
				
				regRT_even[127:64] = $realtobits($bitstoreal(regRA_even[127:64])+ $bitstoreal(regRB_even[127:64]));
				regRT_even[63:0] = $realtobits($bitstoreal(regRA_even[127:64])+ $bitstoreal(regRB_even[63:0]));
			end
			
		//Double Floating Subtract	
		709:	
			begin	
				regRT_even[127:64] = $realtobits($bitstoreal(regRA_even[127:64])- $bitstoreal(regRB_even[127:64]));
				regRT_even[63:0] = $realtobits($bitstoreal(regRA_even[63:0])- $bitstoreal(regRB_even[63:0]));
			end	
			
		//Double Floating Multiply 
		718:
			begin
				regRT_even[127:64] = $realtobits($bitstoreal(regRA_even[127:64])* $bitstoreal(regRB_even[127:64]));
				regRT_even[63:0] = $realtobits($bitstoreal(regRA_even[63:0])* $bitstoreal(regRB_even[63:0]));
			end
			
		//Double Floating Multiply and Add	
		860:
			begin
				regRT_even[127:64] = $realtobits($bitstoreal(regRA_even[127:64])* $bitstoreal(regRB_even[127:64]) + $bitstoreal(regRC_even[127:64]));
				regRT_even[63:0] = $realtobits($bitstoreal(regRA_even[63:0])* $bitstoreal(regRB_even[63:0]) + $bitstoreal(regRC_even[63:0]));
			end
			
		//Double Floating Compare Equal	
		963:
			begin
					if($bitstoreal(regRA_even[127:64])== $bitstoreal(regRB_even[127:64]))
						regRT_even[127:64]='1;
						
					else
						regRT_even[127:64]='0;
						
					if($bitstoreal(regRA_even[63:0])== $bitstoreal(regRB_even[63:0]))
						regRT_even[63:0]='1;
						
					else
						regRT_even[63:0]='0;	
						
						
			end
		//Double Floating Compare Greater Than
		707:
			begin
				if($bitstoreal(regRA_even[127:64]) > $bitstoreal(regRB_even[127:64]))
					regRT_even[127:64]='1;
					
				else
					regRT_even[127:64]='0;
					
				if($bitstoreal(regRA_even[63:0]) > $bitstoreal(regRB_even[63:0]))
					regRT_even[63:0]='1;
					
				else
					regRT_even[63:0]='0;	
			end
		
		
		//---------------------------------------- Compare Instructions ----------------------------------------
		
		//Compare Equal Word
		960:
			begin
				for(int i=0; i<4; i++)
				begin
					if(regRA_even[(32*i) +: 32] == regRB_even[(32*i) +: 32])
						regRT_even[(32*i) +: 32] =32'b11111111111111111111111111111111;
				
					else
						regRT_even[(32*i) +: 32] =0;
				end
			end
			
		//Compare Greater Than Word
		576:
			begin
				for(int i=0; i<4; i++)
				begin
					if(regRA_even[(32*i) +: 32] > regRB_even[(32*i) +: 32])
						regRT_even[(32*i) +: 32] =32'b11111111111111111111111111111111;
				
					else
						regRT_even[(32*i) +: 32] =0;
				end
			end	
		
		//Compare Equal Word Immediate
		124:
			begin
				for(int i=0; i<4; i++)
				begin
					if(regRA_even[(32*i) +: 32] ==  32'(signed'(imm_even[9:0])))
						regRT_even[(32*i) +: 32] =32'b11111111111111111111111111111111;
				
					else
						regRT_even[(32*i) +: 32] =0;
				end
			end
			
		//Compare Greater Than Word Immediate
		76:
			begin
				for(int i=0; i<4; i++)
				begin
					if(regRA_even[(32*i) +: 32] >  32'(signed'(imm_even[9:0])))
						regRT_even[(32*i) +: 32] =32'b11111111111111111111111111111111;
				
					else
						regRT_even[(32*i) +: 32] =0;
				end
			end	
		
		// No operation
		1:	
			begin
			
			end	
			
		endcase
		
			regStg_evencomb[149]=0;
			regStg_evencomb[148:138]=opcode_even;
			regStg_evencomb[137:135]=unitType_even;
			regStg_evencomb[134:128]=regRT_addr_even;
			regStg_evencomb[127:0]=regRT_even;
		
	end
	
	// stage 1
	always_ff @(posedge clk)
	begin
		if(flush==1)
			regStg_1e<= 'x;
		else
			regStg_1e<=regStg_evencomb;
		
		pr_stg1<=priority_reg;
	end

	// stage 2
	always_ff @(posedge clk)
	begin
		
		if(flush==1)
			regStg_2e<= 'x;
		else
		begin
			if(regStg_1e[137:135]==1)
			begin
				regStg_2e[149]<=1;
				regStg_2e[148:0]<=regStg_1e[148:0];
			end
			else
				regStg_2e<=regStg_1e;
			
			pr_stg2<=pr_stg1;	
		end			
	end
	
	// stage 3
	always_ff @(posedge clk)
	begin
		if(flush==1)
			regStg_3e<= 'x;
		else
			regStg_3e<=regStg_2e;
	
		pr_stg3<=pr_stg2;
	end
	
	// stage 4
	always_ff @(posedge clk)
	begin
		if(flush==1)
		begin
			if(pr_stg3==0)
				regStg_4e<= 'x;
		end
		else
		begin
			if((regStg_3e[137:135]==2)||(regStg_3e[137:135]==5))
			begin
				regStg_4e[149]<=1;
				regStg_4e[148:0]<=regStg_3e[148:0];
			end
			else
				regStg_4e<=regStg_3e;
		end
	end
	
	// stage 5
	always_ff @(posedge clk)
	begin
		regStg_5e<=regStg_4e;
	end
	
	// stage 6
	always_ff @(posedge clk)
	begin
		if((regStg_5e[148:138]==716)||(regStg_5e[148:138]==718)||(regStg_5e[148:138]==860)||(regStg_5e[148:138]==963)||(regStg_5e[148:138]==707))
		begin
			regStg_6e[149]<=1;
			regStg_6e[148:0]<=regStg_5e[148:0];			
		end
		else
		regStg_6e<=regStg_5e;
	end
	
	// stage 7
	always_ff @(posedge clk)
	begin
		if((regStg_6e[148:138]==964)||(regStg_6e[148:138]==12)||(regStg_6e[148:138]==965)||(regStg_6e[148:138]==967)||(regStg_6e[148:138]==966))
		begin
			regStg_7e[149]<=1;
			regStg_7e[148:0]<=regStg_6e[148:0];			
		end
		else
			regStg_7e<=regStg_6e;
	end
	
endmodule
