`ifndef VS_ALG_REG_READ_VSEQS_SV
  `define VS_ALG_REG_READ_VSEQS_SV

class vs_alg_reg_read_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_reg_read_vseqs)

  cfs_algn_reg_block block;
  uvm_reg m_reg;
  uvm_reg_field m_fld;
  
  function new(string name = "vs_alg_reg_read_vseqs");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    
    if(m_fld != null)
    begin
      m_fld.mirror(status, UVM_CHECK);
      if(status != UVM_IS_OK)
        `uvm_fatal("REG_READ_SEQ","MISMATCH FOUND IN READ VALUE AND MIRRORED VALUE")
      else
        `uvm_info("REG_READ_SEQ",$sformatf("DATA READ FROM REG_FIELD %0s : %0h", m_fld.get_full_name(), m_fld.get_mirrored_value()),UVM_LOW)
    end
    else
    begin
      m_reg.mirror(status, UVM_CHECK);
      if(status != UVM_IS_OK)
        `uvm_fatal("REG_READ_SEQ","MISMATCH FOUND IN READ VALUE AND MIRRORED VALUE")
      else
        `uvm_info("REG_READ_SEQ",$sformatf("DATA READ FROM REG %0s : %8h", m_reg.get_full_name(), m_reg.get_mirrored_value()),UVM_LOW)
    end
  endtask

  virtual task reg_read(input uvm_sequencer_base vseqr = null, input string reg_name = "", input string fld_name = "");
    if(reg_name == "")
      `uvm_fatal("REG_READ","NO REG_NAME PASSED TO METHOD FOR READING")
    else
    begin
      m_reg = block.get_reg_by_name(reg_name);
      if(m_reg == null)
        `uvm_fatal("REG_READ",$sformatf("NO SUCH REGISTER BY THE NAME %0s",reg_name))
    end
    if(fld_name != "")
    begin
      m_fld = m_reg.get_field_by_name(fld_name);
      if(m_fld == null)
        `uvm_fatal("REG_READ",$sformatf("NO SUCH FIELD BY THE NAME %0s",fld_name))
    end

    this.start(vseqr);
  endtask
endclass

`endif
