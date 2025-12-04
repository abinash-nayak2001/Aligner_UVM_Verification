`ifndef VS_ALG_MAX_DROP_STKY0_REG_TEST_SV
  `define VS_ALG_MAX_DROP_STKY0_REG_TEST_SV

class vs_alg_max_drop_stky0_reg_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_max_drop_stky0_reg_test)

  vs_alg_legal_config_random_vseqs reg_config_seq;
  vs_alg_illegal_rx_random_vseqs rx_illegal_seq;
  vs_alg_reg_read_vseqs reg_read_seq;
  vs_alg_irq_irqen_write_vseqs irqen_write_seq;
  vs_alg_irq_irqen_write_vseqs irq_write_seq;
  vs_alg_clr_reg_vseqs clr_reg_seq;
  int unsigned no_of_reg_trans = 10;
  int unsigned no_of_rx_trans = 26;
  int unsigned total_trans = 0;

  function new(string name = "vs_alg_max_drop_stky0_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;

  
    irqen_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irqen_write_seq");
    irq_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irq_write_seq");
    reg_read_seq = vs_alg_reg_read_vseqs::type_id::create("reg_read_seq");
    irqen_write_seq.block = env.model.reg_block;
    irq_write_seq.block = env.model.reg_block;
    reg_read_seq.block = env.model.reg_block;

    irqen_write_seq.irqen_write(env.virtual_sequencer,"MAX_DROP","ENABLE");

    repeat(no_of_reg_trans)
    begin
      total_trans = 0;
      reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");

      reg_config_seq.start(env.virtual_sequencer);
      repeat(no_of_rx_trans)
      begin
        rx_illegal_seq = vs_alg_illegal_rx_random_vseqs::type_id::create("rx_illegal_seq");

        rx_illegal_seq.start(env.virtual_sequencer);
        total_trans = total_trans + 1;
        if(total_trans > 255) // Checing the non-cyclic nature of STATUS.CNT_CROP
        begin
          reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","CNT_DROP");
          if(env.model.reg_block.STATUS.CNT_DROP.get_mirrored_value() !== 255)
            `uvm_error("RTL_BUG","STATUS.CNT_DROP IS CYCLING BACK AFTER REACHING 255")
        end
      end
    end
    
    // Checking the value of IRQ.MAX_DROP
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","MAX_DROP");
    
    // Setting IRQ.MAX_DROP
    irq_write_seq.irq_write(env.virtual_sequencer,"MAX_DROP",1'b1);

    // Checking Sticky0 behavior of IRQ.MAX_DROP
    reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","CNT_DROP");
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","MAX_DROP");

    //Clearing STATUS.CNT_DROP
    clr_reg_seq = vs_alg_clr_reg_vseqs::type_id::create("clr_reg_seq");
    clr_reg_seq.start(env.virtual_sequencer);

    // After clearing STATUS.CNT_DROP, again making it go from 0->255
    `uvm_info("STKY0_REG_TEST","After clearing STATUS.CNT_DROP, again making it go from 0->255",UVM_LOW)
    repeat(no_of_reg_trans)
    begin
      total_trans = 0;
      reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");

      reg_config_seq.start(env.virtual_sequencer);
      repeat(no_of_rx_trans)
      begin
        rx_illegal_seq = vs_alg_illegal_rx_random_vseqs::type_id::create("rx_illegal_seq");

        rx_illegal_seq.start(env.virtual_sequencer);
        total_trans = total_trans + 1;
        if(total_trans > 255) // Checing the non-cyclic nature of STATUS.CNT_CROP
        begin
          reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","CNT_DROP");
          if(env.model.reg_block.STATUS.CNT_DROP.get_mirrored_value() !== 255)
            `uvm_error("RTL_BUG","STATUS.CNT_DROP IS CYCLING BACK AFTER REACHING 255")
        end
      end
    end

    // Checking the value of IRQ.MAX_DROP
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","MAX_DROP");

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction
endclass

`endif
