/********************************************
TO SEE THE CHANGE IN MIRRORED VALUE OF STATUS.CLR WHEN WRITING INTO IT, CHANGE VERBOSITY TO UVM_HIGH 
*********************************************/

`ifndef VS_ALG_CLR_CNT_DROP_REG_TEST_SV
  `define VS_ALG_CLR_CNT_DROP_REG_TEST_SV
  
class vs_alg_clr_cnt_drop_reg_test extends vs_alg_err_rx_test;
  `uvm_component_utils(vs_alg_clr_cnt_drop_reg_test)

  vs_alg_clr_reg_vseqs clr_reg_seq;

  function new(string name = "vs_alg_clr_cnt_drop_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("\n*****COMPLETED vs_alg_err_rx_test..... NOW RUNNING vs_alg_clr_cnt_drop_reg_test..... *****\n");

    phase.raise_objection(this, "TEST_DONE");
    
    clr_reg_seq = vs_alg_clr_reg_vseqs::type_id::create("clr_reg_seq");
    clr_reg_seq.start(env.virtual_sequencer);

    if(env.model.reg_block.STATUS.CNT_DROP.get_mirrored_value() !== 0)
      `uvm_error("RTL_BUG","STATUS.CNT_DROP DID NOT CLEAR EVEN AFTER WRITING 1 TO CTRL.CLR")

    status_rd_seq = vs_alg_status_read_vseqs::type_id::create("status_rd_seq");
    status_rd_seq.start(env.virtual_sequencer);

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
endclass

`endif
