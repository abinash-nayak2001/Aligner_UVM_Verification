`ifndef VS_ALG_IRQ_IRQEN_WRITE_VSEQS_SV
  `define VS_ALG_IRQ_IRQEN_WRITE_VSEQS_SV 

class vs_alg_irq_irqen_write_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_irq_irqen_write_vseqs)

  cfs_algn_reg_block block;
  uvm_reg_field m_fld;

  function new(string name = "vs_alg_irq_irqen_write_vseqs");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    m_fld.get_parent.update(status);

    `uvm_info("IRQ_IRQEN_SEQ",$sformatf("SUCCESSFULLY PERFORMED WRITE..... MIRRORED VALUE OF %0s : %8h", m_fld.get_parent.get_name(), m_fld.get_parent.get_mirrored_value()),UVM_LOW)
  endtask

  virtual task irqen_write(input uvm_sequencer_base vseqr = null, input string fld_name = "", input string action = "ENABLE");
    uvm_reg m_reg;
    bit val;

    m_reg = block.get_reg_by_name("IRQEN");

    if(fld_name == "")
      `uvm_fatal("IRQEN_WRITE","NO FLD_NAME PASSED TO METHOD FOR WRITING")
    else
    begin
      m_fld = m_reg.get_field_by_name(fld_name);
      if(m_fld == null)
        `uvm_fatal("IRQEN_WRITE",$sformatf("NO SUCH FIELD BY THE NAME %0s",fld_name))
    end

    val = (action == "ENABLE")?1'b1:1'b0;

    m_fld.set(val);
    
    this.start(vseqr);
  endtask

  virtual task irq_write(input uvm_sequencer_base vseqr = null, input string fld_name = "", input bit val);
    uvm_reg m_reg;

    m_reg = block.get_reg_by_name("IRQ");

    if(fld_name == "")
      `uvm_fatal("IRQ_WRITE","NO FLD_NAME PASSED TO METHOD FOR WRITING")
    else
    begin
      m_fld = m_reg.get_field_by_name(fld_name);
      if(m_fld == null)
        `uvm_fatal("IRQ_WRITE",$sformatf("NO SUCH FIELD BY THE NAME %0s",fld_name))
    end

    m_fld.set(val);
    
    this.start(vseqr);
  endtask
endclass

`endif
