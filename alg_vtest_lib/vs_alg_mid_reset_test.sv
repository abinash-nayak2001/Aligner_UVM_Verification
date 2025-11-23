`ifndef VS_ALG_MID_RESET_TEST_SV
	`define VS_ALG_MID_RESET_TEST_SV
 
class vs_alg_mid_reset_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_mid_reset_test)

  vs_alg_legal_config_random_vseqs reg_config_seq;
	vs_alg_empty_tx_vseqs tx_seq;
	vs_alg_legal_rx_random_vseqs rx_seq;
	cfs_apb_vif apb_vif;
  virtual cfs_md_if rx_vif;
  virtual cfs_md_if tx_vif;
	int unsigned n_bytes_in_buffer = 0;
	int unsigned no_of_reg_trans = 1;
  int unsigned no_of_rx_trans = 5;

  function new(string name = "vs_alg_mid_reset_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    env.md_rx_agent.sequencer.set_report_severity_id_override(UVM_ERROR, "SEQREQZMB", UVM_WARNING);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    
    apb_vif = env.apb_agent.agent_config.get_vif();
    rx_vif = env.md_rx_agent.agent_config.get_vif();
    tx_vif = env.md_tx_agent.agent_config.get_vif();
    #50;

    fork : A
      begin
        repeat(2)
          @(posedge tx_vif.valid);
        #2;
        apb_vif.preset_n <= 1'b0;

        repeat(3)
          @(posedge apb_vif.pclk);
        apb_vif.preset_n <= 1'b1;
        n_bytes_in_buffer = 0;
      end

      begin
        repeat(no_of_reg_trans)
        begin
          reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");
          reg_config_seq.block = env.model.reg_block;
        
          reg_config_seq.start(env.virtual_sequencer);
          
          rx_seq = vs_alg_legal_rx_random_vseqs::type_id::create("rx_seq");
          fork
          begin
            n_bytes_in_buffer = 0;
            repeat(no_of_rx_trans)
            begin
              do begin
                rx_seq.start(env.virtual_sequencer);
                n_bytes_in_buffer = n_bytes_in_buffer + rx_seq.seq.item.data.size();
              end while(n_bytes_in_buffer%(reg_config_seq.block.CTRL.SIZE.get_mirrored_value()) != 0);
            end
          end
          
          begin
            do begin
              tx_seq = vs_alg_empty_tx_vseqs::type_id::create("tx_seq");
              tx_seq.start(env.virtual_sequencer);
              n_bytes_in_buffer = n_bytes_in_buffer - reg_config_seq.block.CTRL.SIZE.get_mirrored_value();
              while(n_bytes_in_buffer == 0)
                @(posedge apb_vif.pclk);
            end while(n_bytes_in_buffer != 0);
          end
          join_any
          #50;
        end
      end
    join_any
    disable A;

    #50;

    fork : B
      begin
        repeat(2)
          @(posedge rx_vif.valid);
        #2;
        apb_vif.preset_n <= 1'b0;

        repeat(3)
          @(posedge apb_vif.pclk);
        apb_vif.preset_n <= 1'b1;
        n_bytes_in_buffer = 0;
      end

      begin
        repeat(no_of_reg_trans)
        begin
          reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");
          reg_config_seq.block = env.model.reg_block;
        
          reg_config_seq.start(env.virtual_sequencer);
          
          rx_seq = vs_alg_legal_rx_random_vseqs::type_id::create("rx_seq");
          fork
          begin
            n_bytes_in_buffer = 0;
            repeat(no_of_rx_trans)
            begin
              do begin
                rx_seq.start(env.virtual_sequencer);
                n_bytes_in_buffer = n_bytes_in_buffer + rx_seq.seq.item.data.size();
              end while(n_bytes_in_buffer%(reg_config_seq.block.CTRL.SIZE.get_mirrored_value()) != 0);
            end
          end
          
          begin
            do begin
              tx_seq = vs_alg_empty_tx_vseqs::type_id::create("tx_seq");
              tx_seq.start(env.virtual_sequencer);
              n_bytes_in_buffer = n_bytes_in_buffer - reg_config_seq.block.CTRL.SIZE.get_mirrored_value();
              while(n_bytes_in_buffer == 0)
                @(posedge apb_vif.pclk);
            end while(n_bytes_in_buffer != 0);
          end
          join_any
          #50;
        end
      end
    join_any
    disable B;
    
    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("*****NUMBER OF BYTES LEFT IN ALIGNER WHICH ARE NOT TAKEN OUT AFTER TEST_DONE : %0d*****", n_bytes_in_buffer);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction

endclass

`endif
