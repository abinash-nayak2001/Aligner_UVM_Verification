`ifndef VS_ALG_NO_ADDR_VSEQS_SV
  `define VS_ALG_NO_ADDR_VSEQS_SV

class vs_alg_no_addr_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_no_addr_vseqs)

  rand cfs_apb_sequence_simple seq;
  cfs_algn_reg_block block;

  function new(string name = "vs_alg_no_addr_vseqs");
    super.new(name);
  endfunction

  task body();
    uvm_reg m_regs[$];
    uvm_reg_addr_t m_addr[$];
    block = p_sequencer.model.reg_block;

    block.get_registers(m_regs);

    foreach(m_regs[i])
      m_addr.push_back(m_regs[i].get_address);

    seq = cfs_apb_sequence_simple::type_id::create("seq");
    assert(seq.randomize() with {!item.addr inside {m_addr};}) else
      `uvm_error("NO_ADDR_SEQ","RANDOMIZATION FAILED")

    seq.start(p_sequencer.apb_sequencer);
  endtask
endclass

`endif
