module branchpredict(clk,opcode_odd_ip_dep,unitType_odd_ip_dep,PC_odd_dec,PC_br,flush,branch_stall);

	input clk;
	input [10:0] opcode_odd_ip_dep;
	input [2:0] unitType_odd_ip_dep;
	input [31:0] PC_odd_dec;
	input [31:0] PC_br;
	input flush;
	
	logic branch_predict;
	logic br_nf;
	
	//--------Prediction Table-------
	logic [3:0] [31:0] branch_PC;
	logic [3:0] [0:0] branch_taken;
	logic [3:0]	[0:0] branch_valid;
	//-------------------------------
	
	output logic branch_stall=0;
	
	always_comb
	begin
		// Predicting
		if(unitType_odd_ip_dep==7)
		begin
			// conditional branches
			if(opcode_odd_ip_dep==70 || opcode_odd_ip_dep==68 || opcode_odd_ip_dep==297 || opcode_odd_ip_dep==296)
			begin
				// Search branch in table
				for(int i=0;i<16;i++)
				begin
					if(PC_odd_dec==branch_PC[i] && branch_valid[i]==1)
					begin
						branch_predict=branch_taken[i];
						br_nf=0;
						break;
					end
					else
						br_nf=1;
				end
				// Branch not in table
				if(br_nf==1)
				begin
					for(int i=0;i<16;i++)
					begin
						if(branch_valid[i]!=1)
						begin
							branch_PC[i]=PC_odd_dec;
							branch_taken[i]=0;
							branch_valid[i]=1;
						end
					end
				end
			end
			// unconditional branches
			else
			begin
				branch_predict=1;
			end
		end
		// Updating Prediction
		if(flush==1)
		begin
			for(int i=0;i<16;i++)
			begin
				if(PC_br==branch_PC[i])
				begin
					if(branch_taken[i]==0)
						branch_taken[i]=1;
				end
			end
		end
		else
		begin
			for(int i=0;i<16;i++)
			begin
				if(PC_br==branch_PC[i])
				begin
					if(branch_taken[i]==1)
						branch_taken[i]=0;
				end
			end
		end
		
		// Determine stalling
		if(branch_predict==1)
			branch_stall=1;
		else
			branch_stall=0;
	end
	
endmodule