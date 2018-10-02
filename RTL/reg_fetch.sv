module reg_fetch(clk,regRA_addr_odd,regRB_addr_odd,regRC_addr_odd,regRA_addr_even,regRB_addr_even,regRC_addr_even,opcode_odd_ip, opcode_even_ip,unitType_even_ip,unitType_odd_ip,
				regRT_addr_even_ip,regRT_addr_odd_ip,imm_even_ip,imm_odd_ip,opcode_odd, opcode_even,unitType_even,unitType_odd,regRT_addr_even,regRT_addr_odd,imm_even,imm_odd,
				regRA_odd, regRB_odd, regRC_odd, regRA_even, regRB_even, regRC_even, regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e,
				regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o,reg_file,PC_odd_dep,regPCin,flush,priority_dep,priority_reg);
	
	input clk;
	input [6:0] regRA_addr_odd,regRB_addr_odd,regRC_addr_odd;
	input [6:0] regRA_addr_even,regRB_addr_even,regRC_addr_even;
	
	input [10:0] opcode_odd_ip, opcode_even_ip;
	input [2:0] unitType_even_ip,unitType_odd_ip;
	input [6:0] regRT_addr_even_ip,regRT_addr_odd_ip;
	input signed [15:0] imm_even_ip,imm_odd_ip;
	//input stop_dep;
	
	//output logic stop;
	output logic [10:0] opcode_odd, opcode_even;
	output logic [2:0] unitType_even,unitType_odd;
	output logic [6:0] regRT_addr_even,regRT_addr_odd;
	output logic signed [15:0] imm_even,imm_odd;
	input flush;
	
	output logic [127:0] regRA_odd, regRB_odd, regRC_odd, regRA_even, regRB_even, regRC_even;
	
	input [149:0] regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e;
	input [149:0] regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o;
	
	input [127:0][127:0] reg_file;
	
	input [31:0] PC_odd_dep;
	output logic [31:0] regPCin;
	
	input priority_dep;
	output logic priority_reg;
	
	
	
	always_ff @(posedge clk)
		begin
		
			if(flush==1)
			begin
				regRA_even<='x;
				regRA_odd<='x;
				
				regRB_even<='x;
				regRB_odd<='x;
				
				regRC_even<='x;
				regRC_odd<='x;
				
				opcode_even<='x;
				opcode_odd<='x;
				
				unitType_even<='x;
				unitType_odd<='x;
				
				regRT_addr_even<='x;
				regRT_addr_odd<='x;
				
				imm_even<='x;
				imm_odd<='x;
			end
			
			else
			begin
			//---------------------------------------- Even pipe ----------------------------------------
			// Fetch for RA_even
				if(regRA_addr_even==regStg_2e[134:128] && regStg_2e[149]==1)	
					regRA_even <= regStg_2e[127:0];		
				else if(regRA_addr_even==regStg_3e[134:128] && regStg_3e[149]==1)			
					regRA_even <= regStg_3e[127:0];
				else if(regRA_addr_even==regStg_4e[134:128] && regStg_4e[149]==1)			
					regRA_even <= regStg_4e[127:0];
				else if(regRA_addr_even==regStg_4o[134:128] && regStg_4o[149]==1)			
					regRA_even <= regStg_4o[127:0];
				else if(regRA_addr_even==regStg_5e[134:128] && regStg_5e[149]==1)			
					regRA_even <= regStg_5e[127:0];
				else if(regRA_addr_even==regStg_5o[134:128] && regStg_5o[149]==1)			
					regRA_even <= regStg_5o[127:0];	
				else if(regRA_addr_even==regStg_6e[134:128] && regStg_6e[149]==1)			
					regRA_even <= regStg_6e[127:0];
				else if(regRA_addr_even==regStg_6o[134:128] && regStg_6o[149]==1)			
					regRA_even <= regStg_6o[127:0];
				else if(regRA_addr_even==regStg_7e[134:128] && regStg_7e[149]==1)			
					regRA_even <= regStg_7e[127:0];
				else if(regRA_addr_even==regStg_7o[134:128] && regStg_7o[149]==1)			
					regRA_even <= regStg_7o[127:0];
				else if(regRA_addr_even==regStg_8e[134:128] && regStg_8e[149]==1)			
					regRA_even <= regStg_8e[127:0];
				else if(regRA_addr_even==regStg_8o[134:128] && regStg_8o[149]==1)			
					regRA_even <= regStg_8o[127:0];
				else	
					regRA_even <= reg_file[regRA_addr_even];
				
				// Fetch for RB_even
				if(regRB_addr_even==regStg_2e[134:128] && regStg_2e[149]==1)	
					regRB_even <= regStg_2e[127:0];		
				else if(regRB_addr_even==regStg_3e[134:128] && regStg_3e[149]==1)			
					regRB_even <= regStg_3e[127:0];
				else if(regRB_addr_even==regStg_4e[134:128] && regStg_4e[149]==1)			
					regRB_even <= regStg_4e[127:0];
				else if(regRB_addr_even==regStg_4o[134:128] && regStg_4o[149]==1)			
					regRB_even <= regStg_4o[127:0];
				else if(regRB_addr_even==regStg_5e[134:128] && regStg_5e[149]==1)			
					regRB_even <= regStg_5e[127:0];
				else if(regRB_addr_even==regStg_5o[134:128] && regStg_5o[149]==1)			
					regRB_even <= regStg_5o[127:0];	
				else if(regRB_addr_even==regStg_6e[134:128] && regStg_6e[149]==1)			
					regRB_even <= regStg_6e[127:0];
				else if(regRB_addr_even==regStg_6o[134:128] && regStg_6o[149]==1)			
					regRB_even <= regStg_6o[127:0];
				else if(regRB_addr_even==regStg_7e[134:128] && regStg_7e[149]==1)			
					regRB_even <= regStg_7e[127:0];
				else if(regRB_addr_even==regStg_7o[134:128] && regStg_7o[149]==1)			
					regRB_even <= regStg_7o[127:0];
				else if(regRB_addr_even==regStg_8e[134:128] && regStg_8e[149]==1)			
					regRB_even <= regStg_8e[127:0];
				else if(regRB_addr_even==regStg_8o[134:128] && regStg_8o[149]==1)			
					regRB_even <= regStg_8o[127:0];
				else	
					regRB_even <= reg_file[regRB_addr_even];
				
				// Fetch for RC_even
				if(opcode_even_ip==832 || opcode_even_ip==833 || opcode_even_ip==860)
				begin
					if(regRT_addr_even_ip==regStg_2e[134:128] && regStg_2e[149]==1)	
						regRC_even <= regStg_2e[127:0];		
					else if(regRT_addr_even_ip==regStg_3e[134:128] && regStg_3e[149]==1)			
						regRC_even <= regStg_3e[127:0];
					else if(regRT_addr_even_ip==regStg_4e[134:128] && regStg_4e[149]==1)			
						regRC_even <= regStg_4e[127:0];
					else if(regRT_addr_even_ip==regStg_4o[134:128] && regStg_4o[149]==1)			
						regRC_even <= regStg_4o[127:0];
					else if(regRT_addr_even_ip==regStg_5e[134:128] && regStg_5e[149]==1)			
						regRC_even <= regStg_5e[127:0];
					else if(regRT_addr_even_ip==regStg_5o[134:128] && regStg_5o[149]==1)			
						regRC_even <= regStg_5o[127:0];	
					else if(regRT_addr_even_ip==regStg_6e[134:128] && regStg_6e[149]==1)			
						regRC_even <= regStg_6e[127:0];
					else if(regRT_addr_even_ip==regStg_6o[134:128] && regStg_6o[149]==1)			
						regRC_even <= regStg_6o[127:0];
					else if(regRT_addr_even_ip==regStg_7e[134:128] && regStg_7e[149]==1)			
						regRC_even <= regStg_7e[127:0];
					else if(regRT_addr_even_ip==regStg_7o[134:128] && regStg_7o[149]==1)			
						regRC_even <= regStg_7o[127:0];
					else if(regRT_addr_even_ip==regStg_8e[134:128] && regStg_8e[149]==1)			
						regRC_even <= regStg_8e[127:0];
					else if(regRT_addr_even_ip==regStg_8o[134:128] && regStg_8o[149]==1)		
						regRC_even <= regStg_8o[127:0];
					else	
						regRC_even <= reg_file[regRT_addr_even_ip];
				end
				else	
				begin
					if(regRC_addr_even==regStg_2e[134:128] && regStg_2e[149]==1)	
						regRC_even <= regStg_2e[127:0];		
					else if(regRC_addr_even==regStg_3e[134:128] && regStg_3e[149]==1)			
						regRC_even <= regStg_3e[127:0];
					else if(regRC_addr_even==regStg_4e[134:128] && regStg_4e[149]==1)			
						regRC_even <= regStg_4e[127:0];
					else if(regRC_addr_even==regStg_4o[134:128] && regStg_4o[149]==1)			
						regRC_even <= regStg_4o[127:0];
					else if(regRC_addr_even==regStg_5e[134:128] && regStg_5e[149]==1)			
						regRC_even <= regStg_5e[127:0];
					else if(regRC_addr_even==regStg_5o[134:128] && regStg_5o[149]==1)			
						regRC_even <= regStg_5o[127:0];	
					else if(regRC_addr_even==regStg_6e[134:128] && regStg_6e[149]==1)			
						regRC_even <= regStg_6e[127:0];
					else if(regRC_addr_even==regStg_6o[134:128] && regStg_6o[149]==1)			
						regRC_even <= regStg_6o[127:0];
					else if(regRC_addr_even==regStg_7e[134:128] && regStg_7e[149]==1)			
						regRC_even <= regStg_7e[127:0];
					else if(regRC_addr_even==regStg_7o[134:128] && regStg_7o[149]==1)			
						regRC_even <= regStg_7o[127:0];
					else if(regRC_addr_even==regStg_8e[134:128] && regStg_8e[149]==1)			
						regRC_even <= regStg_8e[127:0];
					else if(regRC_addr_even==regStg_8o[134:128] && regStg_8o[149]==1)		
						regRC_even <= regStg_8o[127:0];
					else	
						regRC_even <= reg_file[regRC_addr_even];
				end
									
				//---------------------------------------- Odd pipe ----------------------------------------
				// Fetch for RA_odd
				if(regRA_addr_odd==regStg_2e[134:128] && regStg_2e[149]==1)	
					regRA_odd <= regStg_2e[127:0];		
				else if(regRA_addr_odd==regStg_3e[134:128] && regStg_3e[149]==1)			
					regRA_odd <= regStg_3e[127:0];
				else if(regRA_addr_odd==regStg_4e[134:128] && regStg_4e[149]==1)			
					regRA_odd <= regStg_4e[127:0];
				else if(regRA_addr_odd==regStg_4o[134:128] && regStg_4o[149]==1)			
					regRA_odd <= regStg_4o[127:0];
				else if(regRA_addr_odd==regStg_5e[134:128] && regStg_5e[149]==1)			
					regRA_odd <= regStg_5e[127:0];
				else if(regRA_addr_odd==regStg_5o[134:128] && regStg_5o[149]==1)			
					regRA_odd <= regStg_5o[127:0];	
				else if(regRA_addr_odd==regStg_6e[134:128] && regStg_6e[149]==1)			
					regRA_odd <= regStg_6e[127:0];
				else if(regRA_addr_odd==regStg_6o[134:128] && regStg_6o[149]==1)			
					regRA_odd <= regStg_6o[127:0];
				else if(regRA_addr_odd==regStg_7e[134:128] && regStg_7e[149]==1)			
					regRA_odd <= regStg_7e[127:0];
				else if(regRA_addr_odd==regStg_7o[134:128] && regStg_7o[149]==1)			
					regRA_odd <= regStg_7o[127:0];
				else if(regRA_addr_odd==regStg_8e[134:128] && regStg_8e[149]==1)			
					regRA_odd <= regStg_8e[127:0];
				else if(regRA_addr_odd==regStg_8o[134:128] && regStg_8o[149]==1)			
					regRA_odd <= regStg_8o[127:0];
				else	
					regRA_odd <= reg_file[regRA_addr_odd];
				
				// Fetch for RB_odd
				if(regRB_addr_odd==regStg_2e[134:128] && regStg_2e[149]==1)	
					regRB_odd <= regStg_2e[127:0];		
				else if(regRB_addr_odd==regStg_3e[134:128] && regStg_3e[149]==1)			
					regRB_odd <= regStg_3e[127:0];
				else if(regRB_addr_odd==regStg_4e[134:128] && regStg_4e[149]==1)			
					regRB_odd <= regStg_4e[127:0];
				else if(regRB_addr_odd==regStg_4o[134:128] && regStg_4o[149]==1)			
					regRB_odd <= regStg_4o[127:0];
				else if(regRB_addr_odd==regStg_5e[134:128] && regStg_5e[149]==1)			
					regRB_odd <= regStg_5e[127:0];
				else if(regRB_addr_odd==regStg_5o[134:128] && regStg_5o[149]==1)			
					regRB_odd <= regStg_5o[127:0];	
				else if(regRB_addr_odd==regStg_6e[134:128] && regStg_6e[149]==1)			
					regRB_odd <= regStg_6e[127:0];
				else if(regRB_addr_odd==regStg_6o[134:128] && regStg_6o[149]==1)			
					regRB_odd <= regStg_6o[127:0];
				else if(regRB_addr_odd==regStg_7e[134:128] && regStg_7e[149]==1)			
					regRB_odd <= regStg_7e[127:0];
				else if(regRB_addr_odd==regStg_7o[134:128] && regStg_7o[149]==1)			
					regRB_odd <= regStg_7o[127:0];
				else if(regRB_addr_odd==regStg_8e[134:128] && regStg_8e[149]==1)			
					regRB_odd <= regStg_8e[127:0];
				else if(regRB_addr_odd==regStg_8o[134:128] && regStg_8o[149]==1)			
					regRB_odd <= regStg_8o[127:0];
				else	
					regRB_odd <= reg_file[regRB_addr_odd];
					
				// Fetch for RC_odd
				if(opcode_odd_ip==324 || opcode_odd_ip==193 || opcode_odd_ip==65 || opcode_odd_ip==71|| opcode_odd_ip==70 || opcode_odd_ip==68|| opcode_odd_ip==296|| opcode_odd_ip==297)
				begin
					if(regRT_addr_odd_ip==regStg_2e[134:128] && regStg_2e[149]==1)	
						regRC_odd <= regStg_2e[127:0];		
					else if(regRT_addr_odd_ip==regStg_3e[134:128] && regStg_3e[149]==1)			
						regRC_odd <= regStg_3e[127:0];
					else if(regRT_addr_odd_ip==regStg_4e[134:128] && regStg_4e[149]==1)			
						regRC_odd <= regStg_4e[127:0];
					else if(regRT_addr_odd_ip==regStg_4o[134:128] && regStg_4o[149]==1)			
						regRC_odd <= regStg_4o[127:0];
					else if(regRT_addr_odd_ip==regStg_5e[134:128] && regStg_5e[149]==1)			
						regRC_odd <= regStg_5e[127:0];
					else if(regRT_addr_odd_ip==regStg_5o[134:128] && regStg_5o[149]==1)			
						regRC_odd <= regStg_5o[127:0];	
					else if(regRT_addr_odd_ip==regStg_6e[134:128] && regStg_6e[149]==1)			
						regRC_odd <= regStg_6e[127:0];
					else if(regRT_addr_odd_ip==regStg_6o[134:128] && regStg_6o[149]==1)			
						regRC_odd <= regStg_6o[127:0];
					else if(regRT_addr_odd_ip==regStg_7e[134:128] && regStg_7e[149]==1)			
						regRC_odd <= regStg_7e[127:0];
					else if(regRT_addr_odd_ip==regStg_7o[134:128] && regStg_7o[149]==1)			
						regRC_odd <= regStg_7o[127:0];
					else if(regRT_addr_odd_ip==regStg_8e[134:128] && regStg_8e[149]==1)			
						regRC_odd <= regStg_8e[127:0];
					else if(regRT_addr_odd_ip==regStg_8o[134:128] && regStg_8o[149]==1)		
						regRC_odd <= regStg_8o[127:0];
					else
						regRC_odd <= reg_file[regRT_addr_odd_ip];
				end
				else
				begin
					if(regRC_addr_odd==regStg_2e[134:128] && regStg_2e[149]==1)	
						regRC_odd <= regStg_2e[127:0];		
					else if(regRC_addr_odd==regStg_3e[134:128] && regStg_3e[149]==1)			
						regRC_odd <= regStg_3e[127:0];
					else if(regRC_addr_odd==regStg_4e[134:128] && regStg_4e[149]==1)			
						regRC_odd <= regStg_4e[127:0];
					else if(regRC_addr_odd==regStg_4o[134:128] && regStg_4o[149]==1)			
						regRC_odd <= regStg_4o[127:0];
					else if(regRC_addr_odd==regStg_5e[134:128] && regStg_5e[149]==1)			
						regRC_odd <= regStg_5e[127:0];
					else if(regRC_addr_odd==regStg_5o[134:128] && regStg_5o[149]==1)			
						regRC_odd <= regStg_5o[127:0];	
					else if(regRC_addr_odd==regStg_6e[134:128] && regStg_6e[149]==1)			
						regRC_odd <= regStg_6e[127:0];
					else if(regRC_addr_odd==regStg_6o[134:128] && regStg_6o[149]==1)			
						regRC_odd <= regStg_6o[127:0];
					else if(regRC_addr_odd==regStg_7e[134:128] && regStg_7e[149]==1)			
						regRC_odd <= regStg_7e[127:0];
					else if(regRC_addr_odd==regStg_7o[134:128] && regStg_7o[149]==1)			
						regRC_odd <= regStg_7o[127:0];
					else if(regRC_addr_odd==regStg_8e[134:128] && regStg_8e[149]==1)			
						regRC_odd <= regStg_8e[127:0];
					else if(regRC_addr_odd==regStg_8o[134:128] && regStg_8o[149]==1)			
						regRC_odd <= regStg_8o[127:0];
					else	
						regRC_odd <= reg_file[regRC_addr_odd];	
				end
				
				opcode_even<=opcode_even_ip;
				opcode_odd<=opcode_odd_ip;
				
				unitType_even<=unitType_even_ip;
				unitType_odd<=unitType_odd_ip;
				
				regRT_addr_even<=regRT_addr_even_ip;
				regRT_addr_odd<=regRT_addr_odd_ip;
				
				imm_even<=imm_even_ip;
				imm_odd<=imm_odd_ip;
				
				regPCin<=PC_odd_dep;
				
				priority_reg<=priority_dep;
				//stop<=stop_dep;
				end
		end
	
endmodule
