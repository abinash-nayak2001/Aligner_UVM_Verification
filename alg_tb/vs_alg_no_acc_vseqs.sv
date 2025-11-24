`ifndef VS_ALG_NO_ACC_VSEQS_SV
  `define VS_ALG_NO_ACC_VSEQS_SV

class vs_alg_no_acc_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_no_acc_vseqs)

  rand cfs_apb_sequence_simple seq;
  cfs_algn_reg_block block;

  function new(string name = "vs_alg_no_acc_vseqs");
    super.new(name);
  endfunction

  task body();
    uvm_reg status_reg;
    uvm_reg_addr_t m_addr;
    block = p_sequencer.model.reg_block;

    status_reg = block.get_reg_by_name("STATUS");
    m_addr = status_reg.get_address();

    seq = cfs_apb_sequence_simple::type_id::create("seq");
    assert(seq.randomize() with {item.addr == m_addr; item.dir == CFS_APB_WRITE;}) else
      `uvm_error("NO_ACC_SEQ","RANDOMIZATION FAILED")

    seq.start(p_sequencer.apb_sequencer);

  endtask
endclass

`endif
