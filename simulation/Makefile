# SIMULATOR = Questa for Mentor's Questasim

SIMULATOR = Questa

RTL = ../rtl/*
work = work #library name
SVTB1 = ../alg_tb/top.sv
INC = +incdir+../ext_agent +incdir+../alg_apb_agent +incdir+../alg_md_agent +incdir+../alg_RAL +incdir+../alg_tb +incdir+../alg_vtest_lib
SVTB2 = ../ext_agent/uvm_ext_pkg.sv
SVTB3 = ../alg_apb_agent/cfs_apb_pkg.sv
SVTB4 = ../alg_md_agent/cfs_md_pkg.sv
SVTB5 = ../alg_RAL/cfs_algn_reg_pkg.sv
SVTB6 = ../alg_tb/cfs_algn_pkg.sv
SVTB7 = ../alg_vtest_lib/cfs_algn_test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov4;run -all; exit"


help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                  								!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.  						!"
	@echo "! sv_cmp    	=>  Create library and compile the code.           						!"
	@echo "! run_test	=>  clean, compile & run the simulation for ram_signle_adddr_test in batch mode.		!" 
	@echo "! run_test1	=>  clean, compile & run the simulation for ram_ten_addr_test in batch mode.			!" 
	@echo "! run_test2	=>  clean, compile & run the simulation for ram_odd_addr_test in batch mode.			!"
	@echo "! run_test3	=>  clean, compile & run the simulation for ram_even_addr_test in batch mode.			!" 
	@echo "! view_wave1 =>  To view the waveform of ram_signle_addr_test	    						!" 
	@echo "! view_wave2 =>  To view the waveform of ram_ten_addr_test	    						!" 
	@echo "! view_wave3 =>  To view the waveform of ram_odd_addr_test 	  						!" 
	@echo "! view_wave4 =>  To view the waveform of ram_even_addr_test    							!" 
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.							!"
	@echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
run_test4 : run_test4_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

regress1 : regress1_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog +acc=rnb -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB3) $(SVTB4) $(SVTB5) $(SVTB6) $(SVTB7) $(SVTB1)
	
run_test1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log -sv_seed 2609961934 work.top +UVM_TESTNAME=vs_alg_mid_reset_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov1
	
run_test2_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_legal_reg_rx_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov2
	
run_test3_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=vs_alg_err_reg_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov3
	
run_test4_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file4.wlf -l test4.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_err_rx_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov4
	
view_wave1_Questa:
	vsim -view wave_file1.wlf
	
view_wave2_Questa:
	vsim -view wave_file2.wlf
	
view_wave3_Questa:
	vsim -view wave_file3.wlf
	
view_wave4_Questa:
	vsim -view wave_file4.wlf

report_Questa:
	vcover merge vs_alg_cov vs_alg_cov1 vs_alg_cov2 vs_alg_cov3 vs_alg_cov4
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa report_Questa cov_Questa

regress1_Questa: clean_Questa run_test1_Questa run_test2_Questa run_test3_Questa
	vcover merge vs_alg_cov vs_alg_cov1 vs_alg_cov2 vs_alg_cov3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov

cov_Questa:
	firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* vs_alg_cov* *.wlf modelsim.ini work
	clear

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#
