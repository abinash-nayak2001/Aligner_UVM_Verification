`ifndef VS_ALG_RX_FIFO_FULL_TEST_SV
  `define VS_ALG_RX_FIFO_FULL_TEST_SV

class vs_alg_rx_fifo_full_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_rx_fifo_full_test)
  
  vs_alg_reg_read_vseqs reg_read_seq;
  vs_alg_irq_irqen_write_vseqs irqen_write_seq;
  vs_alg_ctrl_size_write_vseqs size_write_seq;
  vs_alg_max_size_rx_vseqs msize_rx_seq;
  vs_alg_empty_tx_vseqs tx_seq;
  int unsigned n_msize_seq = 15;
  int unsigned n_bytes_in_buffer = 0;
  int unsigned total_trans = 0;

  function new(string name = "vs_alg_rx_fifo_full_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    env.agent_config.set_stuck_threshold(5000);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;
    
    irqen_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irqen_write_seq");
    reg_read_seq = vs_alg_reg_read_vseqs::type_id::create("reg_read_seq");
    size_write_seq = vs_alg_ctrl_size_write_vseqs::type_id::create("size_write_seq");
    msize_rx_seq = vs_alg_max_size_rx_vseqs::type_id::create("msize_rx_seq");
    irqen_write_seq.block = env.model.reg_block;
    reg_read_seq.block = env.model.reg_block;

    irqen_write_seq.irqen_write(env.virtual_sequencer,"RX_FIFO_FULL","ENABLE");
    size_write_seq.write_size(env.virtual_sequencer, 3'h1);

    n_bytes_in_buffer = 0;
    repeat(11)
    begin
      msize_rx_seq.start(env.virtual_sequencer);
      total_trans = total_trans + 1;
      n_bytes_in_buffer = n_bytes_in_buffer + 4;
      if(total_trans > 10)
      begin
        reg_read_seq.reg_read(env.virtual_sequencer,"STATUS"); // Checking STATUS.RX_FIFO_LVL and STATUS.TX_FIFO_LVL does not exceed 8
      end
    end

    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ");
    
    fork
      begin
        repeat(n_msize_seq-11)
        begin
          msize_rx_seq.start(env.virtual_sequencer);
          n_bytes_in_buffer = n_bytes_in_buffer + 4;
        end
      end

      begin
       	do begin
          tx_seq = vs_alg_empty_tx_vseqs::type_id::create("tx_seq");
          tx_seq.start(env.virtual_sequencer);
          n_bytes_in_buffer = n_bytes_in_buffer - env.model.reg_block.CTRL.SIZE.get_mirrored_value();
        end while(n_bytes_in_buffer != 0); 
      end
    join
    
    #50;
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ");

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
