module decode(clk,instr_1, instr_2,IF_valid,dep_ready,dec_valid,dec_ready,regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep,
regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep,opcode_odd_ip_dep, opcode_even_ip_dep,unitType_even_ip_dep,unitType_odd_ip_dep,regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep,
 imm_even_ip_dep,imm_odd_ip_dep,PC_instr_1, PC_instr_2,PC_odd_dec,flush,priority_dec);
	
	input clk;
	input [31:0] instr_1, instr_2;
	
	logic [6:0] regRA_addr_i1,regRB_addr_i1,regRC_addr_i1;
	logic [6:0] regRA_addr_i2,regRB_addr_i2,regRC_addr_i2;
	
	logic [6:0] regRT_addr_i1, regRT_addr_i2;
	
	logic [15:0] imm_i1,imm_i2;
	logic [2:0] unitType_i1,unitType_i2;
	logic [10:0] opcode_instr1,opcode_instr2;
	
	output logic [6:0] regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep;
	output logic [6:0] regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep;
	
	output logic [10:0] opcode_odd_ip_dep, opcode_even_ip_dep;
	output logic [2:0] unitType_even_ip_dep,unitType_odd_ip_dep;
	output logic [6:0] regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep;
	output logic signed [15:0] imm_even_ip_dep,imm_odd_ip_dep;
	
	input logic IF_valid;
	input logic dep_ready;
	output logic dec_valid;
	output logic dec_ready=1;
	
	logic done_first=0;
	logic done_second=0;
	
	input [31:0] PC_instr_1, PC_instr_2;
	output logic [31:0] PC_odd_dec;
	
	output logic priority_dec;
	input flush;
	logic stop;
	
	
	always_comb
	begin
		if(IF_valid==1)
	//instruction 1 decoding
		begin
		if(instr_1[31:28]==12 || instr_1[31:28]==8)			
			begin
				opcode_instr1=11'(instr_1[31:28]);
				regRT_addr_i1=instr_1[27:21];
				regRB_addr_i1=instr_1[20:14];
				regRA_addr_i1=instr_1[13:7];
				regRC_addr_i1=instr_1[6:0];
			end
			
		else if(instr_1[31:24]==28 || instr_1[31:24]==29 || instr_1[31:24]==116 ||instr_1[31:24]==20 ||instr_1[31:24]==4 ||instr_1[31:24]==124 ||instr_1[31:24]==76 ||instr_1[31:24]==13)
			begin
				opcode_instr1=11'(instr_1[31:24]);
				imm_i1=16'(signed'(instr_1[23:14]));
				regRA_addr_i1=instr_1[13:7];
				regRT_addr_i1=instr_1[6:0];
			end
			
		else if(instr_1[31:23]==97 || instr_1[31:23]==101 || instr_1[31:23]==103 || instr_1[31:23]==65 || instr_1[31:23]==71 || instr_1[31:23]==131 || instr_1[31:23]==130 || instr_1[31:23]==129 || instr_1[31:23]==193 || instr_1[31:23]==100 || instr_1[31:23]==96 || instr_1[31:23]==70 || instr_1[31:23]==102 || instr_1[31:23]==98|| instr_1[31:23]==68)
		begin
			opcode_instr1=11'(instr_1[31:23]);
			imm_i1=instr_1[22:7];
			regRT_addr_i1=instr_1[6:0];
		
		end
				
		else
		begin
			opcode_instr1=11'(instr_1[31:21]);
			regRB_addr_i1=instr_1[20:14];
			regRA_addr_i1=instr_1[13:7];
			regRT_addr_i1=instr_1[6:0];
		end
		
	
	
	//instruction 2 decoding
	
		if(instr_2[31:28]==12 || instr_2[31:28]==8)
			begin
				opcode_instr2=11'(instr_2[31:28]);
				regRT_addr_i2=instr_2[27:21];
				regRB_addr_i2=instr_2[20:14];
				regRA_addr_i2=instr_2[13:7];
				regRC_addr_i2=instr_2[6:0];
			end
			
		else if(instr_2[31:24]==28 || instr_2[31:24]==29 || instr_2[31:24]==116 ||instr_2[31:24]==20 ||instr_2[31:24]==4 ||instr_2[31:24]==124 ||instr_2[31:24]==76 ||instr_2[31:24]==13)
			begin
				opcode_instr2=11'(instr_2[31:24]);
				imm_i2=16'(signed'(instr_2[23:14]));
				regRA_addr_i2=instr_2[13:7];
				regRT_addr_i2=instr_2[6:0];
			end
			
		else if(instr_2[31:23]==97 || instr_2[31:23]==101 || instr_2[31:23]==103 || instr_2[31:23]==65 || instr_2[31:23]==71 || instr_2[31:23]==131 || instr_2[31:23]==130 || instr_2[31:23]==129 || instr_2[31:23]==193 || instr_2[31:23]==100 || instr_2[31:23]==96 || instr_2[31:23]==70 || instr_2[31:23]==102 || instr_2[31:23]==98|| instr_2[31:23]==68)
		begin
			opcode_instr2=11'(instr_2[31:23]);
			imm_i2=instr_2[22:7];
			regRT_addr_i2=instr_2[6:0];
		
		end
				
		else
		begin
			opcode_instr2=11'(instr_2[31:21]);
			regRB_addr_i2=instr_2[20:14];
			regRA_addr_i2=instr_2[13:7];
			regRT_addr_i2=instr_2[6:0];
		end
	
		if(instr_1[31:21]==0)			//stop
		begin
			stop=1;
			opcode_instr2='x;
			regRT_addr_i2='x;
			regRB_addr_i2='x;
			regRA_addr_i2='x;
			regRC_addr_i2='x;
			imm_i2='x;
			unitType_i2='x;
		end 
				
		else if(instr_2[31:21]==0)			//stop
		begin
			stop=1;
		end  
		
		//computing unitType
		if(opcode_instr1==101 ||opcode_instr1==200 ||opcode_instr1==29 ||opcode_instr1==192 ||opcode_instr1==28 ||opcode_instr1==64 ||opcode_instr1==116 ||opcode_instr1==832 || opcode_instr1==194 ||opcode_instr1==833 ||opcode_instr1==66 ||opcode_instr1==677 || opcode_instr1==692 ||opcode_instr1==438 ||opcode_instr1==193 ||opcode_instr1==20 ||opcode_instr1==713 ||opcode_instr1==4 ||opcode_instr1==577 ||opcode_instr1==201 ||opcode_instr1==8 ||opcode_instr1==960 ||opcode_instr1==576 ||opcode_instr1==124 ||opcode_instr1==76 ||opcode_instr1==705)
			unitType_i1=1;
		else if(opcode_instr1==686 ||opcode_instr1==95 ||opcode_instr1==91 ||opcode_instr1==92)
			unitType_i1=2;
		else if(opcode_instr1==452 || opcode_instr1==97 || opcode_instr1==320 || opcode_instr1==103 || opcode_instr1==324 || opcode_instr1==65 || opcode_instr1==71 || opcode_instr1==131 || opcode_instr1==130 || opcode_instr1==129 || opcode_instr1==193)
			unitType_i1=3;
		else if(opcode_instr1==12 ||opcode_instr1==965 ||opcode_instr1==967 ||opcode_instr1==966 ||opcode_instr1==708 ||opcode_instr1==709 ||opcode_instr1==710 ||opcode_instr1==962 ||opcode_instr1==14 ||opcode_instr1==706)	
			unitType_i1=4;
		else if(opcode_instr1==83 ||opcode_instr1==595 ||opcode_instr1==211)
			unitType_i1=5;
		else if(opcode_instr1==434 ||opcode_instr1==479 ||opcode_instr1==476 ||opcode_instr1==472)
			unitType_i1=6;
		else if(opcode_instr1==98 ||opcode_instr1==102 ||opcode_instr1==296 ||opcode_instr1==297 ||opcode_instr1==70 ||opcode_instr1==68 ||opcode_instr1==424 ||opcode_instr1==96 ||opcode_instr1==100)	
			unitType_i1=7;

		if(opcode_instr2==101 ||opcode_instr2==200 ||opcode_instr2==29 ||opcode_instr2==192 ||opcode_instr2==28 ||opcode_instr2==64 ||opcode_instr2==116 ||opcode_instr2==832 || opcode_instr2==194 ||opcode_instr2==833 ||opcode_instr2==66 ||opcode_instr2==677 || opcode_instr2==692 ||opcode_instr2==438 ||opcode_instr2==193 ||opcode_instr2==20 ||opcode_instr2==713 ||opcode_instr2==4 ||opcode_instr2==577 ||opcode_instr2==201 ||opcode_instr2==8 ||opcode_instr2==960 ||opcode_instr2==576 ||opcode_instr2==124 ||opcode_instr2==76 ||opcode_instr2==705)
			unitType_i2=1;
		else if(opcode_instr2==686 ||opcode_instr2==95 ||opcode_instr2==91 ||opcode_instr2==92)
			unitType_i2=2;
		else if(opcode_instr2==452 || opcode_instr2==97 || opcode_instr1==320 || opcode_instr2==103 || opcode_instr2==324 || opcode_instr2==65 || opcode_instr2==71 || opcode_instr2==131 || opcode_instr2==130 || opcode_instr2==129 || opcode_instr2==193)
			unitType_i2=3;
		else if(opcode_instr2==12 ||opcode_instr2==965 ||opcode_instr2==967 ||opcode_instr2==966 ||opcode_instr2==708 ||opcode_instr2==709 ||opcode_instr2==710 ||opcode_instr2==962 ||opcode_instr2==14 ||opcode_instr2==706)	
			unitType_i2=4;
		else if(opcode_instr2==83 ||opcode_instr2==595 ||opcode_instr2==211)
			unitType_i2=5;
		else if(opcode_instr2==434 ||opcode_instr2==479 ||opcode_instr2==476 ||opcode_instr2==472)
			unitType_i2=6;
		else if(opcode_instr2==98 ||opcode_instr2==102 ||opcode_instr2==296 ||opcode_instr2==297 ||opcode_instr2==70 ||opcode_instr2==68 ||opcode_instr2==424 ||opcode_instr2==96 ||opcode_instr2==100)	
			unitType_i2=7;
		
		dec_ready=0;
	end
	
	if(flush==1)
		begin
			opcode_instr1='x;
			regRT_addr_i1='x;
			regRB_addr_i1='x;
			regRA_addr_i1='x;
			regRC_addr_i1='x;
			imm_i1='x;
			unitType_i1='x;
			
			opcode_instr2='x;
			regRT_addr_i2='x;
			regRB_addr_i2='x;
			regRA_addr_i2='x;
			regRC_addr_i2='x;
			imm_i2='x;
			unitType_i2='x;
			
		end
		
	
	if((done_first==1 && done_second==1) || flush==1)
		dec_ready=1;
		
end
	

always_ff @(posedge clk)
begin

	if(IF_valid==1)
		done_second<=0;
	
	if(dep_ready==1)
	begin
		// BOTH ODD
		if((unitType_i1==3 || unitType_i1==6 || unitType_i1==7) && (unitType_i2==3 || unitType_i2==6 || unitType_i2==7))
			begin
					if(done_first==0)
					begin
						
						opcode_odd_ip_dep<=opcode_instr1;
						unitType_odd_ip_dep<=unitType_i1;
						regRA_addr_odd_dep<=regRA_addr_i1;
						regRB_addr_odd_dep<=regRB_addr_i1;
						regRC_addr_odd_dep<=regRC_addr_i1;
						imm_odd_ip_dep<=imm_i1;
						regRT_addr_odd_ip_dep<=regRT_addr_i1;
						PC_odd_dec<=PC_instr_1;
						priority_dec<='x;
						
						opcode_even_ip_dep<=1;
						regRT_addr_even_ip_dep<='x;
						dec_valid<=1;
						done_first<=1;
						
						
					end
					
					else if(done_first==1)
					begin
						
						opcode_odd_ip_dep<=opcode_instr2;
						unitType_odd_ip_dep<=unitType_i2;
						regRA_addr_odd_dep<=regRA_addr_i2;
						regRB_addr_odd_dep<=regRB_addr_i2;
						regRC_addr_odd_dep<=regRC_addr_i2;
						imm_odd_ip_dep<=imm_i2;
						regRT_addr_odd_ip_dep<=regRT_addr_i2;
						PC_odd_dec<=PC_instr_2;
						priority_dec<='x;
						
						opcode_even_ip_dep<=1;
						regRT_addr_even_ip_dep<='x;
						dec_valid<=1;
						done_first<=0;
						done_second<=1;
					end
				
			end
			
		//Both even	
		else if((unitType_i1==1 || unitType_i1==2 || unitType_i1==4 || unitType_i1==5) && (unitType_i2==1 || unitType_i2==2 || unitType_i2==4 || unitType_i2==5))	
			begin
					if(done_first==0)
					begin
						opcode_even_ip_dep<=opcode_instr1;
						unitType_even_ip_dep<=unitType_i1;
						regRA_addr_even_dep<=regRA_addr_i1;
						regRB_addr_even_dep<=regRB_addr_i1;
						regRC_addr_even_dep<=regRC_addr_i1;
						imm_even_ip_dep<=imm_i1;
						regRT_addr_even_ip_dep<=regRT_addr_i1;
						priority_dec<='x;
						
						PC_odd_dec<='x;
						opcode_odd_ip_dep<=513;
						regRT_addr_odd_ip_dep<='x;
						dec_valid<=1;
						done_first<=1;
					end
					
					else if(done_first==1)
					begin
						opcode_even_ip_dep<=opcode_instr2;
						unitType_even_ip_dep<=unitType_i2;
						regRA_addr_even_dep<=regRA_addr_i2;
						regRB_addr_even_dep<=regRB_addr_i2;
						regRC_addr_even_dep<=regRC_addr_i2;
						imm_even_ip_dep<=imm_i2;
						regRT_addr_even_ip_dep<=regRT_addr_i2;
						priority_dec<='x;
						
						PC_odd_dec<='x;
						opcode_odd_ip_dep<=513;
						regRT_addr_odd_ip_dep<='x;
						dec_valid<=1;
						done_first<=0;
						done_second<=1;
					end
				
			end
		// EVEN & ODD	
		else
		begin
			if(regRT_addr_i1==regRT_addr_i2)			// WAW
			begin
				if(unitType_i1==1 || unitType_i1==2 || unitType_i1==4 || unitType_i1==5)  //First is even
				begin
					if(done_first!=1)
					begin
						opcode_even_ip_dep<=opcode_instr1;
						unitType_even_ip_dep<=unitType_i1;
						regRA_addr_even_dep<=regRA_addr_i1;
						regRB_addr_even_dep<=regRB_addr_i1;
						regRC_addr_even_dep<=regRC_addr_i1;
						imm_even_ip_dep<=imm_i1;
						regRT_addr_even_ip_dep<=regRT_addr_i1;
						priority_dec<=1;
						
						PC_odd_dec<='x;
						opcode_odd_ip_dep<=513;
						regRT_addr_odd_ip_dep<='x;
						dec_valid<=1;
						done_first<=1;
					end
					
					else
					begin
						opcode_odd_ip_dep<=opcode_instr2;
						unitType_odd_ip_dep<=unitType_i2;
						regRA_addr_odd_dep<=regRA_addr_i2;
						regRB_addr_odd_dep<=regRB_addr_i2;
						regRC_addr_odd_dep<=regRC_addr_i2;
						imm_odd_ip_dep<=imm_i2;
						regRT_addr_odd_ip_dep<=regRT_addr_i2;
						PC_odd_dec<=PC_instr_2;
						priority_dec<=0;
						
						opcode_even_ip_dep<=1;
						regRT_addr_even_ip_dep<='x;
						dec_valid<=1;
						done_first<=0;
						done_second<=1;
					end
				end
				
				else 		// First is odd
				begin
					if(done_first!=1)
					begin
						opcode_odd_ip_dep<=opcode_instr1;
						unitType_odd_ip_dep<=unitType_i1;
						regRA_addr_odd_dep<=regRA_addr_i1;
						regRB_addr_odd_dep<=regRB_addr_i1;
						regRC_addr_odd_dep<=regRC_addr_i1;
						imm_even_ip_dep<=imm_i1;
						regRT_addr_odd_ip_dep<=regRT_addr_i1;
						PC_odd_dec<=PC_instr_1;
						
						priority_dec<=0;
						opcode_even_ip_dep<=1;
						regRT_addr_even_ip_dep<='x;
						dec_valid<=1;
						done_first<=1;
					end
					
					else
					begin
						opcode_even_ip_dep<=opcode_instr2;
						unitType_even_ip_dep<=unitType_i2;
						regRA_addr_even_dep<=regRA_addr_i2;
						regRB_addr_even_dep<=regRB_addr_i2;
						regRC_addr_even_dep<=regRC_addr_i2;
						imm_even_ip_dep<=imm_i2;
						regRT_addr_even_ip_dep<=regRT_addr_i2;
						priority_dec<='x;
						
						PC_odd_dec<='x;
						opcode_odd_ip_dep<=513;
						regRT_addr_odd_ip_dep<='x;
						dec_valid<=1;
						done_first<=0;
						done_second<=1;
					end
				end
			end
			
			else
			begin
				if(unitType_i1==1 || unitType_i1==2 || unitType_i1==4 || unitType_i1==5)
				begin
					opcode_even_ip_dep<=opcode_instr1;
					unitType_even_ip_dep<=unitType_i1;
					regRA_addr_even_dep<=regRA_addr_i1;
					regRB_addr_even_dep<=regRB_addr_i1;
					regRC_addr_even_dep<=regRC_addr_i1;
					imm_even_ip_dep<=imm_i1;
					regRT_addr_even_ip_dep<=regRT_addr_i1;
					priority_dec<=1;
					
					opcode_odd_ip_dep<=opcode_instr2;
					unitType_odd_ip_dep<=unitType_i2;
					regRA_addr_odd_dep<=regRA_addr_i2;
					regRB_addr_odd_dep<=regRB_addr_i2;
					regRC_addr_odd_dep<=regRC_addr_i2;
					imm_odd_ip_dep<=imm_i2;
					regRT_addr_odd_ip_dep<=regRT_addr_i2;
					PC_odd_dec<=PC_instr_2;
					
					dec_valid<=1;
				end
				
				else
				begin
					opcode_odd_ip_dep<=opcode_instr1;
					unitType_odd_ip_dep<=unitType_i1;
					regRA_addr_odd_dep<=regRA_addr_i1;
					regRB_addr_odd_dep<=regRB_addr_i1;
					regRC_addr_odd_dep<=regRC_addr_i1;
					imm_odd_ip_dep<=imm_i1;
					regRT_addr_odd_ip_dep<=regRT_addr_i1;
					PC_odd_dec<=PC_instr_1;
					
					opcode_even_ip_dep<=opcode_instr2;
					unitType_even_ip_dep<=unitType_i2;
					regRA_addr_even_dep<=regRA_addr_i2;
					regRB_addr_even_dep<=regRB_addr_i2;
					regRC_addr_even_dep<=regRC_addr_i2;
					imm_even_ip_dep<=imm_i2;
					regRT_addr_even_ip_dep<=regRT_addr_i2;
					priority_dec<=0;
					dec_valid<=1;
				end
			end
		end
	end
	else
	begin
		dec_valid<=0;
	end

end
endmodule	