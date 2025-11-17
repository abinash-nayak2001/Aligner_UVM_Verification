`ifndef VS_ALG_MASTER_LEGAL_RX_SEQ_SV
  `define VS_ALG_MASTER_LEGAL_RX_SEQ_SV

class vs_alg_master_legal_rx_seq extends cfs_md_sequence_base_master;
    
    //Item to drive
    rand cfs_md_item_drv_master item;
    
    `uvm_object_utils(vs_alg_master_legal_rx_seq)
    
    function new(string name = "vs_alg_master_legal_rx_seq");
      super.new(name);
      
      item = cfs_md_item_drv_master::type_id::create("item");
    endfunction
  
    virtual task body();
      `uvm_send(item)
    endtask
endclass

`endif
