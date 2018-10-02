module dep(clk,regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep,regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep,opcode_odd_ip_dep, opcode_even_ip_dep,
			unitType_even_ip_dep,unitType_odd_ip_dep,regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep,imm_even_ip_dep,imm_odd_ip_dep,flush,regRA_addr_odd,regRB_addr_odd,regRC_addr_odd,
			regRA_addr_even,regRB_addr_even,regRC_addr_even,opcode_odd_ip, opcode_even_ip,unitType_even_ip,unitType_odd_ip,regRT_addr_even_ip,regRT_addr_odd_ip,imm_even_ip,imm_odd_ip,
			regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e,regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o,
			dec_valid,dep_ready,PC_odd_dec,PC_odd_dep,priority_dec,priority_dep);
	
	input clk;
	
	input [6:0] regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep;
	input [6:0] regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep;
	
	input [10:0] opcode_odd_ip_dep, opcode_even_ip_dep;
	input [2:0] unitType_even_ip_dep,unitType_odd_ip_dep;
	input [6:0] regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep;
	input signed [15:0] imm_even_ip_dep,imm_odd_ip_dep;
	input flush;
	
	input  priority_dec;
	output logic priority_dep;
	
	output logic [6:0] regRA_addr_odd,regRB_addr_odd,regRC_addr_odd;
	output logic [6:0] regRA_addr_even,regRB_addr_even,regRC_addr_even;
	
	output logic [10:0] opcode_odd_ip, opcode_even_ip;
	output logic [2:0] unitType_even_ip,unitType_odd_ip;
	output logic [6:0] regRT_addr_even_ip,regRT_addr_odd_ip;
	output logic signed [15:0] imm_even_ip,imm_odd_ip;
	
	input [149:0] regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e;
	input [149:0] regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o;
	
	input [31:0] PC_odd_dec;
	output logic [31:0] PC_odd_dep;
	
	logic [3:0] latency_even,latency_odd;
	logic even_done,odd_done;
	logic [3:0] stall_even,stall_odd;
	
	input dec_valid;
	output logic dep_ready=1;
	
	logic even_io,odd_ie;
	
	always_comb
	begin
		if(dec_valid==1)
		begin
			//---------------------------------------- Even Pipe ----------------------------------------
			latency_even=1;
			//Dependency_Stage check Odd Pipe
			if((regRA_addr_even_dep==regRT_addr_odd_ip_dep) || regRB_addr_even_dep==regRT_addr_odd_ip_dep || regRC_addr_even_dep==regRT_addr_odd_ip_dep)
			begin
				even_io=1;
				if((unitType_odd_ip_dep==6) || (unitType_odd_ip_dep==7))
					latency_even=5;
				else if(unitType_odd_ip_dep==3)
					latency_even=7;
			end
			// Stage Reg_fetch_even
			else if((regRA_addr_even_dep==regRT_addr_even_ip) || (regRB_addr_even_dep==regRT_addr_even_ip) || (regRC_addr_even_dep==regRT_addr_even_ip))
			begin
				if(unitType_even_ip==1)
					latency_even=2;
				else if(unitType_even_ip==2 || unitType_even_ip==5)
					latency_even=4;
				else if(unitType_even_ip==4)
				begin
					if((opcode_even_ip==716) || (opcode_even_ip==718) || (opcode_even_ip==860) || (opcode_even_ip==963) || (opcode_even_ip==707))
						latency_even=6;
					else if((opcode_even_ip==716) || (opcode_even_ip==718) || (opcode_even_ip==860) || (opcode_even_ip==963) || (opcode_even_ip==707))
						latency_even=7;
				end
			end
			else if((regRA_addr_even_dep==regRT_addr_odd_ip) || (regRB_addr_even_dep==regRT_addr_odd_ip) || (regRC_addr_even_dep==regRT_addr_odd_ip))
			begin
				if((unitType_odd_ip==6) || (unitType_odd_ip==7))
					latency_even=4;
				else if(unitType_odd_ip==3)
					latency_even=6;
			end
			// Stage 1_even
			else if(regRA_addr_even_dep==regStg_1e[134:128] || regRB_addr_even_dep==regStg_1e[134:128] || regRC_addr_even_dep==regStg_1e[134:128])
			begin
				if(regStg_1e[137:135]==1)
					latency_even=1;
				else if((regStg_1e[137:135]==2) || (regStg_1e[137:135]==5))
					latency_even=3;
				else if(regStg_1e[137:135]==4)
				begin
					if((regStg_1e[148:138]==716)||(regStg_1e[148:138]==718)||(regStg_1e[148:138]==860)||(regStg_1e[148:138]==963)||(regStg_1e[148:138]==707))
						latency_even=5;
					else if((regStg_1e[148:138]==964)||(regStg_1e[148:138]==12)||(regStg_1e[148:138]==965)||(regStg_1e[148:138]==967)||(regStg_1e[148:138]==966))
						latency_even=6;
				end
			
			end
			else if(regRA_addr_even_dep==regStg_1o[134:128] || regRB_addr_even_dep==regStg_1o[134:128] || regRC_addr_even_dep==regStg_1o[134:128])
			begin
				if((regStg_1o[137:135]==6) || (regStg_1o[137:135]==7))
					latency_even=3;
				else if((regStg_1o[137:135]==3))
					latency_even=5;
			end
			
			// Stage 2_even
			else if(regRA_addr_even_dep==regStg_2e[134:128] || regRB_addr_even_dep==regStg_2e[134:128] || regRC_addr_even_dep==regStg_2e[134:128])
			begin
				if((regStg_2e[137:135]==2) || (regStg_2e[137:135]==5))
					latency_even=2;
				else if(regStg_1e[137:135]==4)
				begin
					if((regStg_2e[148:138]==716)||(regStg_2e[148:138]==718)||(regStg_2e[148:138]==860)||(regStg_2e[148:138]==963)||(regStg_2e[148:138]==707))
						latency_even=4;
					else if((regStg_2e[148:138]==964)||(regStg_2e[148:138]==12)||(regStg_2e[148:138]==965)||(regStg_2e[148:138]==967)||(regStg_2e[148:138]==966))
						latency_even=5;
				end
			
			end
			else if(regRA_addr_even_dep==regStg_2o[134:128] || regRB_addr_even_dep==regStg_2o[134:128] || regRC_addr_even_dep==regStg_2o[134:128])
			begin
				if((regStg_2o[137:135]==6) || (regStg_2o[137:135]==7))
					latency_even=2;
				else if((regStg_2o[137:135]==3))
					latency_even=4;
			end
			
			// Stage 3_even
			else if(regRA_addr_even_dep==regStg_3e[134:128] || regRB_addr_even_dep==regStg_3e[134:128] || regRC_addr_even_dep==regStg_3e[134:128])
			begin
				if((regStg_3e[137:135]==2) || (regStg_3e[137:135]==5))
					latency_even=1;
				else if(regStg_3e[137:135]==4)
				begin
					if((regStg_3e[148:138]==716)||(regStg_3e[148:138]==718)||(regStg_3e[148:138]==860)||(regStg_3e[148:138]==963)||(regStg_3e[148:138]==707))
						latency_even=3;
					else if((regStg_3e[148:138]==964)||(regStg_3e[148:138]==12)||(regStg_3e[148:138]==965)||(regStg_3e[148:138]==967)||(regStg_3e[148:138]==966))
						latency_even=4;
				end
			
			end
			else if(regRA_addr_even_dep==regStg_3o[134:128] || regRB_addr_even_dep==regStg_3o[134:128] || regRC_addr_even_dep==regStg_3o[134:128])
			begin
				if((regStg_3o[137:135]==6) || (regStg_3o[137:135]==7))
					latency_even=1;
				else if((regStg_3o[137:135]==3))
					latency_even=3;
			end
			
			// Stage 4_even
			else if(regRA_addr_even_dep==regStg_4e[134:128] || regRB_addr_even_dep==regStg_4e[134:128] || regRC_addr_even_dep==regStg_4e[134:128])
			begin
				/* if((regStg_4e[137:135]==2) || (regStg_4e[137:135]==5))
					latency_even=1; */
				if(regStg_4e[137:135]==4)
				begin
					if((regStg_4e[148:138]==716)||(regStg_4e[148:138]==718)||(regStg_4e[148:138]==860)||(regStg_4e[148:138]==963)||(regStg_4e[148:138]==707))
						latency_even=2;
					else if((regStg_4e[148:138]==964)||(regStg_4e[148:138]==12)||(regStg_4e[148:138]==965)||(regStg_4e[148:138]==967)||(regStg_4e[148:138]==966))
						latency_even=3;
				end
			
			end
			else if(regRA_addr_even_dep==regStg_4o[134:128] || regRB_addr_even_dep==regStg_4o[134:128] || regRC_addr_even_dep==regStg_4o[134:128])
			begin
				/* if((regStg_4o[137:135]==6) || (regStg_4o[137:135]==7))
					latency_even=1; */
				if((regStg_4o[137:135]==3))
					latency_even=2;
			end
			
			// Stage 5_even
			else if(regRA_addr_even_dep==regStg_5e[134:128] || regRB_addr_even_dep==regStg_5e[134:128] || regRC_addr_even_dep==regStg_5e[134:128])
			begin
				if(regStg_5e[137:135]==4)
				begin
					if((regStg_5e[148:138]==716)||(regStg_5e[148:138]==718)||(regStg_5e[148:138]==860)||(regStg_5e[148:138]==963)||(regStg_5e[148:138]==707))
						latency_even=1;
					else if((regStg_5e[148:138]==964)||(regStg_5e[148:138]==12)||(regStg_5e[148:138]==965)||(regStg_5e[148:138]==967)||(regStg_5e[148:138]==966))
						latency_even=2;
				end
			
			end
			else if(regRA_addr_even_dep==regStg_5o[134:128] || regRB_addr_even_dep==regStg_5o[134:128] || regRC_addr_even_dep==regStg_5o[134:128])
			begin
				if((regStg_5o[137:135]==3))
					latency_even=1;
			end
			
			// Stage 6_even
			else if(regRA_addr_even_dep==regStg_6e[134:128] || regRB_addr_even_dep==regStg_6e[134:128] || regRC_addr_even_dep==regStg_6e[134:128])
			begin
				if(regStg_6e[137:135]==4)
				begin
					/* if((regStg_6e[148:138]==716)||(regStg_6e[148:138]==718)||(regStg_6e[148:138]==860)||(regStg_6e[148:138]==963)||(regStg_6e[148:138]==707))
						latency_even=1; */
					if((regStg_6e[148:138]==964)||(regStg_6e[148:138]==12)||(regStg_6e[148:138]==965)||(regStg_6e[148:138]==967)||(regStg_6e[148:138]==966))
						latency_even=1;
				end
			
			end
			/* else if(regRA_addr_even_dep==regStg_6o[134:128] || regRB_addr_even_dep==regStg_6o[134:128] || regRC_addr_even_dep==regStg_6o[134:128])
			begin
				if((regStg_6o[137:135]==3))
					latency_even=1;
			end */
			
			// Stage 7_even
			/* else if(regRA_addr_even_dep==regStg_7e[134:128] || regRB_addr_even_dep==regStg_7e[134:128] || regRC_addr_even_dep==regStg_7e[134:128])
				if(regStg_7e[137:135]==4)
				begin
					if((regStg_7e[148:138]==964)||(regStg_7e[148:138]==12)||(regStg_7e[148:138]==965)||(regStg_7e[148:138]==967)||(regStg_7e[148:138]==966))
						latency_even=1;
				end */
				
			
			//---------------------------------------- Odd Pipe ----------------------------------------
			
			latency_odd=1;
			// Dependency_Stage check Even pipe
			if((regRA_addr_odd_dep==regRT_addr_even_ip_dep) || (regRB_addr_odd_dep==regRT_addr_even_ip_dep) || (regRC_addr_odd_dep==regRT_addr_even_ip_dep))
			begin
				odd_ie=1;
				if(unitType_even_ip_dep==1)
					latency_odd=3;
				else if(unitType_even_ip_dep==2 || unitType_even_ip_dep==5)
					latency_odd=5;
				else if(unitType_even_ip_dep==4)
					if((opcode_even_ip_dep==716) || (opcode_even_ip_dep==718) || (opcode_even_ip_dep==860) || (opcode_even_ip_dep==963) || (opcode_even_ip_dep==707))
						latency_odd=7;
					else if((opcode_even_ip_dep==716) || (opcode_even_ip_dep==718) || (opcode_even_ip_dep==860) || (opcode_even_ip_dep==963) || (opcode_even_ip_dep==707))
						latency_odd=8;
			end
			// Stage Reg_fetch_odd
			else if(regRA_addr_odd_dep==regRT_addr_even_ip || regRB_addr_odd_dep==regRT_addr_even_ip || regRC_addr_odd_dep==regRT_addr_even_ip)
			begin
				if(unitType_even_ip==1)
					latency_odd=2;
				else if(unitType_even_ip==2 || unitType_even_ip==5)
					latency_odd=4;
				else if(unitType_even_ip==4)
				begin
					if((opcode_even_ip==716) || (opcode_even_ip==718) || (opcode_even_ip==860) || (opcode_even_ip==963) || (opcode_even_ip==707))
						latency_odd=6;
					else if((opcode_even_ip==716) || (opcode_even_ip==718) || (opcode_even_ip==860) || (opcode_even_ip==963) || (opcode_even_ip==707))
						latency_odd=7;
				end
			end
			else if(regRA_addr_odd_dep==regRT_addr_odd_ip || regRB_addr_odd_dep==regRT_addr_odd_ip || regRC_addr_odd_dep==regRT_addr_odd_ip)
			begin
				if((unitType_odd_ip==6) || (unitType_odd_ip==7))
					latency_odd=4;
				else if(unitType_odd_ip==3)
					latency_odd=6;
			end
			// Stage 1_odd
			else if(regRA_addr_odd_dep==regStg_1e[134:128] || regRB_addr_odd_dep==regStg_1e[134:128] || regRC_addr_odd_dep==regStg_1e[134:128])
			begin
				if(regStg_1e[137:135]==1)
					latency_odd=1;
				else if((regStg_1e[137:135]==2) || (regStg_1e[137:135]==5))
					latency_odd=3;
				else if(regStg_1e[137:135]==4)
				begin
					if((regStg_1e[148:138]==716)||(regStg_1e[148:138]==718)||(regStg_1e[148:138]==860)||(regStg_1e[148:138]==963)||(regStg_1e[148:138]==707))
						latency_odd=5;
					else if((regStg_1e[148:138]==964)||(regStg_1e[148:138]==12)||(regStg_1e[148:138]==965)||(regStg_1e[148:138]==967)||(regStg_1e[148:138]==966))
						latency_odd=6;
				end
			
			end
			else if(regRA_addr_odd_dep==regStg_1o[134:128] || regRB_addr_odd_dep==regStg_1o[134:128] || regRC_addr_odd_dep==regStg_1o[134:128])
			begin
				if((regStg_1o[137:135]==6) || (regStg_1o[137:135]==7))
					latency_odd=3;
				else if((regStg_1o[137:135]==3))
					latency_odd=5;
			end
			
			// Stage 2_odd
			else if(regRA_addr_odd_dep==regStg_2e[134:128] || regRB_addr_odd_dep==regStg_2e[134:128] || regRC_addr_odd_dep==regStg_2e[134:128])
			begin
				if((regStg_2e[137:135]==2) || (regStg_2e[137:135]==5))
					latency_odd=2;
				else if(regStg_1e[137:135]==4)
				begin
					if((regStg_2e[148:138]==716)||(regStg_2e[148:138]==718)||(regStg_2e[148:138]==860)||(regStg_2e[148:138]==963)||(regStg_2e[148:138]==707))
						latency_odd=4;
					else if((regStg_2e[148:138]==964)||(regStg_2e[148:138]==12)||(regStg_2e[148:138]==965)||(regStg_2e[148:138]==967)||(regStg_2e[148:138]==966))
						latency_odd=5;
				end
			
			end
			else if(regRA_addr_odd_dep==regStg_2o[134:128] || regRB_addr_odd_dep==regStg_2o[134:128] || regRC_addr_odd_dep==regStg_2o[134:128])
			begin
				if((regStg_2o[137:135]==6) || (regStg_2o[137:135]==7))
					latency_odd=2;
				else if((regStg_2o[137:135]==3))
					latency_odd=4;
			end
			
			// Stage 3_odd
			else if(regRA_addr_odd_dep==regStg_3e[134:128] || regRB_addr_odd_dep==regStg_3e[134:128] || regRC_addr_odd_dep==regStg_3e[134:128])
			begin
				if((regStg_3e[137:135]==2) || (regStg_3e[137:135]==5))
					latency_odd=1;
				else if(regStg_3e[137:135]==4)
				begin
					if((regStg_3e[148:138]==716)||(regStg_3e[148:138]==718)||(regStg_3e[148:138]==860)||(regStg_3e[148:138]==963)||(regStg_3e[148:138]==707))
						latency_odd=3;
					else if((regStg_3e[148:138]==964)||(regStg_3e[148:138]==12)||(regStg_3e[148:138]==965)||(regStg_3e[148:138]==967)||(regStg_3e[148:138]==966))
						latency_odd=4;
				end
			
			end
			else if(regRA_addr_odd_dep==regStg_3o[134:128] || regRB_addr_odd_dep==regStg_3o[134:128] || regRC_addr_odd_dep==regStg_3o[134:128])
			begin
				if((regStg_3o[137:135]==6) || (regStg_3o[137:135]==7))
					latency_odd=1;
				else if((regStg_3o[137:135]==3))
					latency_odd=3;
			end
			
			// Stage 4_odd
			else if(regRA_addr_odd_dep==regStg_4e[134:128] || regRB_addr_odd_dep==regStg_4e[134:128] || regRC_addr_odd_dep==regStg_4e[134:128])
			begin
				/* if((regStg_4e[137:135]==2) || (regStg_4e[137:135]==5))
					latency_odd=1; */
				if(regStg_4e[137:135]==4)
				begin
					if((regStg_4e[148:138]==716)||(regStg_4e[148:138]==718)||(regStg_4e[148:138]==860)||(regStg_4e[148:138]==963)||(regStg_4e[148:138]==707))
						latency_odd=2;
					else if((regStg_4e[148:138]==964)||(regStg_4e[148:138]==12)||(regStg_4e[148:138]==965)||(regStg_4e[148:138]==967)||(regStg_4e[148:138]==966))
						latency_odd=3;
				end
			
			end
			else if(regRA_addr_odd_dep==regStg_4o[134:128] || regRB_addr_odd_dep==regStg_4o[134:128] || regRC_addr_odd_dep==regStg_4o[134:128])
			begin
				/* if((regStg_4o[137:135]==6) || (regStg_4o[137:135]==7))
					latency_odd=1; */
				if((regStg_4o[137:135]==3))
					latency_odd=2;
			end
			
			// Stage 5_odd
			else if(regRA_addr_odd_dep==regStg_5e[134:128] || regRB_addr_odd_dep==regStg_5e[134:128] || regRC_addr_odd_dep==regStg_5e[134:128])
			begin
				if(regStg_5e[137:135]==4)
				begin
					if((regStg_5e[148:138]==716)||(regStg_5e[148:138]==718)||(regStg_5e[148:138]==860)||(regStg_5e[148:138]==963)||(regStg_5e[148:138]==707))
						latency_odd=1;
					else if((regStg_5e[148:138]==964)||(regStg_5e[148:138]==12)||(regStg_5e[148:138]==965)||(regStg_5e[148:138]==967)||(regStg_5e[148:138]==966))
						latency_odd=2;
				end
			
			end
			else if(regRA_addr_odd_dep==regStg_5o[134:128] || regRB_addr_odd_dep==regStg_5o[134:128] || regRC_addr_odd_dep==regStg_5o[134:128])
			begin
				if((regStg_5o[137:135]==3))
					latency_odd=1;
			end
			
			// Stage 6_odd
			else if(regRA_addr_odd_dep==regStg_6e[134:128] || regRB_addr_odd_dep==regStg_6e[134:128] || regRC_addr_odd_dep==regStg_6e[134:128])
			begin
				if(regStg_6e[137:135]==4)
				begin
					/* if((regStg_6e[148:138]==716)||(regStg_6e[148:138]==718)||(regStg_6e[148:138]==860)||(regStg_6e[148:138]==963)||(regStg_6e[148:138]==707))
						latency_odd=1; */
					if((regStg_6e[148:138]==964)||(regStg_6e[148:138]==12)||(regStg_6e[148:138]==965)||(regStg_6e[148:138]==967)||(regStg_6e[148:138]==966))
						latency_odd=1;
				end
			
			end
			/* else if(regRA_addr_odd_dep==regStg_6o[134:128] || regRB_addr_odd_dep==regStg_6o[134:128] || regRC_addr_odd_dep==regStg_6o[134:128])
			begin
				if((regStg_6o[137:135]==3))
					latency_odd=1;
			end */
			
			// Stage 7_odd
			/* else if(regRA_addr_odd_dep==regStg_7e[134:128] || regRB_addr_odd_dep==regStg_7e[134:128] || regRC_addr_odd_dep==regStg_7e[134:128])
				if(regStg_7e[137:135]==4)
				begin
					if((regStg_7e[148:138]==964)||(regStg_7e[148:138]==12)||(regStg_7e[148:138]==965)||(regStg_7e[148:138]==967)||(regStg_7e[148:138]==966))
						latency_odd=1;
				end */
			
			dep_ready=0;
		end
		
			if(even_io==1)
			begin
				latency_even=latency_even+latency_odd;
			end
			else if(odd_ie==1)
			begin
				latency_odd=latency_odd+latency_even;
			end
			else
			begin
				if(priority_dec==1)
				begin
					if(latency_even>latency_odd)
						latency_odd=latency_even;
				end
				else
				begin
					if(latency_odd>latency_even)
						latency_even=latency_odd;
				end
			end
			
			if((odd_done==1 && even_done==1)&&(latency_even==1||stall_even==1)&&(latency_odd==1 || stall_odd==1))
			begin
				dep_ready=1;
				even_io=0;
				odd_ie=0;
			end
	end
	
	always_ff @(posedge clk)
	begin

		if(flush==1)
		begin
			opcode_even_ip<='x;
			unitType_even_ip='x;
			regRA_addr_even<='x;
			regRB_addr_even<='x;
			regRC_addr_even<='x;
			regRT_addr_even_ip<='x;
			imm_even_ip<='x;
			even_done<=1;
			
			opcode_odd_ip<='x;
			unitType_odd_ip<='x;
			regRA_addr_odd<='x;
			regRB_addr_odd<='x;
			regRC_addr_odd<='x;
			regRT_addr_odd_ip<='x;
			imm_odd_ip<='x;
			PC_odd_dep<='x;
			odd_done<=1;
		end
			
		else
		begin
			// Even Pipe
			if(latency_even==1 || stall_even==1)
			begin
				opcode_even_ip<=opcode_even_ip_dep;
				unitType_even_ip<=unitType_even_ip_dep;
				regRA_addr_even<=regRA_addr_even_dep;
				regRB_addr_even<=regRB_addr_even_dep;
				regRC_addr_even<=regRC_addr_even_dep;
				regRT_addr_even_ip<= regRT_addr_even_ip_dep;
				imm_even_ip<=imm_even_ip_dep;
				priority_dep<=priority_dec;
				even_done<=1;
			end
			else
			begin
				if(dec_valid==1)
				begin
					stall_even<=latency_even-1;
					even_done<=0;
					opcode_even_ip<=1;
				end
				else
				begin
					if(stall_even>1)
					begin
						stall_even<=stall_even-1;
						opcode_even_ip<=1;
					end
				end
			end	
			
			// Odd Pipe
			if(latency_odd==1 || stall_odd==1)
			begin
				opcode_odd_ip<=opcode_odd_ip_dep;
				unitType_odd_ip<=unitType_odd_ip_dep;
				regRA_addr_odd<=regRA_addr_odd_dep;
				regRB_addr_odd<=regRB_addr_odd_dep;
				regRC_addr_odd<=regRC_addr_odd_dep;
				regRT_addr_odd_ip<=regRT_addr_odd_ip_dep;
				imm_odd_ip<=imm_odd_ip_dep;
				PC_odd_dep<=PC_odd_dec;
				odd_done<=1;
			end
			else
			begin
				if(dec_valid==1)
				begin
					stall_odd<=latency_odd-1;
					odd_done<=0;
					opcode_odd_ip<=513;
				end
				else
				begin
					if(stall_odd>1)
					stall_odd<=stall_odd-1;
					opcode_odd_ip<=513;
				end
			end	
			
			// Validation
			if(odd_done==0 && even_done==1)
				opcode_even_ip=1;
			else if(odd_done==1 && even_done==0)
				opcode_odd_ip=513;
				
				
			
		end
	end

endmodule