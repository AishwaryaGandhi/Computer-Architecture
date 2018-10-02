module main(clk,reg_file,loc_str,load,instructions);
	
	input clk;
	input load;
	input [31:0]instructions[127:0];
	
	logic [31:0] instr_1,instr_2;
	logic [31:0] PC_instr_1,PC_instr_2;
	
	//---------- CACHE ----------
	logic [1:0][0:0] cache_v;
	logic [1:0] [22:0] cache_tag;
	logic [127:0][7:0] cache_block0;
	logic [127:0][7:0] cache_block1;
	logic [127:0][7:0] cache_block2;
	logic [127:0][7:0] cache_block3;
	//---------------------------
	
	logic [10:0] opcode_even_ip,opcode_odd_ip;
	logic [6:0] regRT_addr_even_ip,regRT_addr_odd_ip;
	logic signed [15:0] imm_even_ip,imm_odd_ip;
	logic [2:0] unitType_even_ip,unitType_odd_ip;
	
	logic [6:0] regRA_addr_odd,regRB_addr_odd,regRC_addr_odd;
	logic [6:0] regRA_addr_even,regRB_addr_even,regRC_addr_even;
	
	logic [10:0] opcode_odd, opcode_even;
	logic [2:0] unitType_even,unitType_odd;
	logic [6:0] regRT_addr_even,regRT_addr_odd;
	logic signed [15:0] imm_even,imm_odd;
	
	logic signed [127:0] regRA_even,regRB_even,regRC_even;
	logic signed [127:0] regRA_odd,regRB_odd,regRC_odd;
	logic signed [127:0] regRT_even,regRT_odd;
	logic flush;				
	
	logic [149:0] regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e;
	logic [149:0] regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o;
	
	output logic [127:0][127:0] reg_file;
	output logic [32768:0][7:0] loc_str;
	
	logic [6:0] regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep;
	logic [6:0] regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep;
	
	logic [10:0] opcode_odd_ip_dep, opcode_even_ip_dep;
	logic [2:0] unitType_even_ip_dep,unitType_odd_ip_dep;
	logic [6:0] regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep;
	logic signed [15:0] imm_even_ip_dep,imm_odd_ip_dep;
	
	logic [31:0] PC_odd_dec,PC_odd_dep,regPCin,regPCout,PC_br;
	
	logic dec_valid,dec_ready;
	logic IF_valid,dep_ready;
	
	logic branch_stall;
	
	ifetch Instr_Fetch(clk,regPCout,dec_ready,cache_load,flush,cache_block0,cache_block1,cache_block2,cache_block3,cache_tag,cache_v,instr_1,instr_2,PC_instr_1,PC_instr_2,IF_valid,branch_stall);
	
	decode Decode(clk,instr_1, instr_2,IF_valid,dep_ready,dec_valid,dec_ready,regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep,
					regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep,opcode_odd_ip_dep, opcode_even_ip_dep,unitType_even_ip_dep,unitType_odd_ip_dep,regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep,
					imm_even_ip_dep,imm_odd_ip_dep,PC_instr_1, PC_instr_2,PC_odd_dec,flush,priority_dec);
	
	dep Dependency(clk,regRA_addr_odd_dep,regRB_addr_odd_dep,regRC_addr_odd_dep,regRA_addr_even_dep,regRB_addr_even_dep,regRC_addr_even_dep,opcode_odd_ip_dep, opcode_even_ip_dep,
			unitType_even_ip_dep,unitType_odd_ip_dep,regRT_addr_even_ip_dep,regRT_addr_odd_ip_dep,imm_even_ip_dep,imm_odd_ip_dep,flush,regRA_addr_odd,regRB_addr_odd,regRC_addr_odd,
			regRA_addr_even,regRB_addr_even,regRC_addr_even,opcode_odd_ip, opcode_even_ip,unitType_even_ip,unitType_odd_ip,regRT_addr_even_ip,regRT_addr_odd_ip,imm_even_ip,imm_odd_ip,
			regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e,regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o,
			dec_valid,dep_ready,PC_odd_dec,PC_odd_dep,priority_dec,priority_dep);
			
	branchpredict BranchPrediction(clk,opcode_odd_ip_dep,unitType_odd_ip_dep,PC_odd_dec,PC_br,flush,branch_stall);
	
	reg_fetch Reg_Fetch(clk,regRA_addr_odd,regRB_addr_odd,regRC_addr_odd,regRA_addr_even,regRB_addr_even,regRC_addr_even,opcode_odd_ip, opcode_even_ip,unitType_even_ip,unitType_odd_ip,
				regRT_addr_even_ip,regRT_addr_odd_ip,imm_even_ip,imm_odd_ip,opcode_odd, opcode_even,unitType_even,unitType_odd,regRT_addr_even,regRT_addr_odd,imm_even,imm_odd,
				regRA_odd, regRB_odd, regRC_odd, regRA_even, regRB_even, regRC_even, regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,regStg_8e,
				regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,regStg_8o,reg_file,PC_odd_dep,regPCin,flush,priority_dep,priority_reg);
	
	evenpipe EvenPipe(clk,opcode_even,regRA_even, regRB_even, regRC_even,imm_even,unitType_even,regRT_addr_even,regRT_even,regStg_evencomb,regStg_1e,regStg_2e,regStg_3e,regStg_4e,regStg_5e,regStg_6e,regStg_7e,flush,reg_file,priority_reg);

	oddpipe OddPipe(clk,opcode_odd,regRA_odd,regRB_odd,regRC_odd,imm_odd,unitType_odd,regRT_addr_odd,regRT_odd,regStg_oddcomb,regStg_1o,regStg_2o,regStg_3o,regStg_4o,regStg_5o,regStg_6o,regStg_7o,loc_str,flush,regPCin,regPCout,cache_v,cache_block1,cache_block2,cache_block3,cache_block0,cache_tag,cache_load,load,instructions,PC_br);

	wb WriteBack(clk,regStg_7e,regStg_7o,regStg_8e,regStg_8o,reg_file);
	
	

endmodule
 