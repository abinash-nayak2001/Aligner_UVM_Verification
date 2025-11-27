`ifndef VS_ALG_ERR_RX_TEST_SV
  `define VS_ALG_ERR_RX_TEST_SV

class vs_alg_err_rx_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_err_rx_test)
  
  int unsigned n_bytes_in_buffer = 0;
  
  function new(string name = "vs_alg_err_rx_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("*****NUMBER OF BYTES LEFT IN ALIGNER WHICH ARE NOT TAKEN OUT AFTER TEST_DONE : %0d*****", n_bytes_in_buffer);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction
endclass

`endif
