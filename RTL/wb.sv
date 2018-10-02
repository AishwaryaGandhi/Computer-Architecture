module wb(clk,regStg_7e,regStg_7o,regStg_8e,regStg_8o,reg_file);
	input clk;
	input logic [149:0] regStg_7e;
	input logic [149:0] regStg_7o;
	
	output logic [149:0] regStg_8e;
	output logic [149:0] regStg_8o;
	output logic [127:0][127:0] reg_file;
	
always_ff @(posedge clk)
	begin
		regStg_8o<=regStg_7o;
		regStg_8e<=regStg_7e;
		
		reg_file[regStg_7e[134:128]]<=regStg_7e[127:0];
		reg_file[regStg_7o[134:128]]<= regStg_7o[127:0];
		
	end
endmodule	
