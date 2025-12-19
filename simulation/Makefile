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
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov8;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov9;run -all; exit"
VSIMBATCH10= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov10;run -all; exit"
VSIMBATCH11= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov11;run -all; exit"
VSIMBATCH12= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov12;run -all; exit"
VSIMBATCH13= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov13;run -all; exit"
VSIMBATCH14= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov14;run -all; exit"
VSIMBATCH15= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov15;run -all; exit"
VSIMBATCH16= -c -do  " log -r /* ;coverage save -onexit vs_alg_cov16;run -all; exit"


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
clean_all : clean_all_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
run_test4 : run_test4_$(SIMULATOR)
run_test5 : run_test5_$(SIMULATOR)
run_test6 : run_test6_$(SIMULATOR)
run_test7 : run_test7_$(SIMULATOR)
run_test8 : run_test8_$(SIMULATOR)
run_test9 : run_test9_$(SIMULATOR)
run_test10 : run_test10_$(SIMULATOR)
run_test11 : run_test11_$(SIMULATOR)
run_test12 : run_test12_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

regress1 : regress1_$(SIMULATOR)
regress2 : regress2_$(SIMULATOR)
regress3 : regress3_$(SIMULATOR)

run_covtest1 : run_covtest1_$(SIMULATOR)
run_covtest2 : run_covtest2_$(SIMULATOR)
run_covtest3 : run_covtest3_$(SIMULATOR)
run_covtest4 : run_covtest4_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog +acc=nrb -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB3) $(SVTB4) $(SVTB5) $(SVTB6) $(SVTB7) $(SVTB1)
	
run_test1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log -sv_seed 1966936817 work.top +UVM_TESTNAME=vs_alg_mid_reset_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov1
	
run_test2_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_legal_reg_rx_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov2
	
run_test3_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=vs_alg_err_reg_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov3
	
run_test4_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_err_rx_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov4
	
run_test5_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_clr_cnt_drop_reg_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov5

run_test6_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_max_drop_stky0_reg_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov6

run_test7_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_max_drop_stky1_reg_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov7

run_test8_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_rx_fifo_full_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov8

run_test9_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave_file9.wlf -l test9.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_rx_fifo_empty_stky0_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov9

run_test10_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10)  -wlf wave_file10.wlf -l test10.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_rx_fifo_empty_stky1_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov10

run_test11_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH11)  -wlf wave_file11.wlf -l test11.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_tx_fifo_empty_stky0_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov11

run_test12_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH12)  -wlf wave_file12.wlf -l test12.log -sv_seed 2602086051 work.top +UVM_TESTNAME=vs_alg_tx_fifo_empty_stky1_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov12

run_covtest1_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH13)  -wlf wave_file13.wlf -l test13.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_tx_err_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov13
	vcover merge vs_alg_cov_mer1 vs_alg_cov vs_alg_cov13
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_mer1

run_covtest2_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH14)  -wlf wave_file14.wlf -l test14.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_reg_read_all_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov14
	vcover merge vs_alg_cov_mer2 vs_alg_cov_mer1 vs_alg_cov14
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_mer2

run_covtest3_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH15)  -wlf wave_file15.wlf -l test15.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_tx_len_cov_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov15
	vcover merge vs_alg_cov_mer3 vs_alg_cov_mer2 vs_alg_cov15
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_mer3

run_covtest4_Questa: clean sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH16)  -wlf wave_file16.wlf -l test16.log -sv_seed random work.top +UVM_TESTNAME=vs_alg_rx_len_cov_test +UVM_MAX_QUIT_COUNT=1 +UVM_VERBOSITY=UVM_LOW -f message.f
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov16
	vcover merge vs_alg_cov_mer4 vs_alg_cov_mer3 vs_alg_cov16
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_mer4

report_Questa:
	vcover merge vs_alg_cov vs_alg_cov_m1 vs_alg_cov_m2 vs_alg_cov_m3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa report_Questa cov_Questa

regress1_Questa: run_test1_Questa run_test2_Questa run_test3_Questa
	vcover merge vs_alg_cov_m1 vs_alg_cov1 vs_alg_cov2 vs_alg_cov3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_m1

regress2_Questa: run_test5_Questa run_test7_Questa run_test8_Questa
	vcover merge vs_alg_cov_m2 v vs_alg_cov5 vs_alg_cov7 vs_alg_cov8
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_m2

regress3_Questa: run_test10_Questa run_test12_Questa
	vcover merge vs_alg_cov_m3 vs_alg_cov10 vs_alg_cov12
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html vs_alg_cov_m3

cov_Questa:
	firefox --new-window covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* *.vstf *.vcd *.wlf modelsim.ini work
	clear

clean_all_Questa:
	rm -rf transcript* *log* fcover* covhtml* vs_alg_cov* *.vstf *.vcd *.wlf modelsim.ini work
	clear
# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#
