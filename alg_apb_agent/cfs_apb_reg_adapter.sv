`ifndef cfs_apb_reg_adapter_SV
  `define cfs_apb_reg_adapter_SV

class cfs_apb_reg_adapter extends uvm_reg_adapter;
    
    `uvm_object_utils(cfs_apb_reg_adapter)
    cfs_apb_item_mon item_mon_copy;
    
    function new(string name = "");
      super.new(name);  
    endfunction
    
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
      cfs_apb_item_mon item_mon;
      cfs_apb_item_drv item_drv;
      
      if($cast(item_mon, bus_item)) begin
        rw.kind = item_mon.dir == CFS_APB_WRITE? UVM_WRITE : UVM_READ;
        
        rw.addr   = item_mon.addr;
        rw.data   = item_mon.data;
        rw.status = item_mon.response == CFS_APB_OKAY ? UVM_IS_OK : UVM_NOT_OK;
        item_mon_copy = cfs_apb_item_mon::type_id::create("item_mon_copy");
        item_mon_copy.dir = item_mon.dir;
        item_mon_copy.addr = item_mon.addr;
        item_mon_copy.data = item_mon.data;
        item_mon_copy.response = item_mon.response;
        `uvm_info("MON_BUS2REG",$sformatf("CASTING SUCCESSFUL WITH ITEM_MON..... ADDR :%0h, DATA : %0h, STATUS : %0s",rw.addr, rw.data, rw.status),UVM_FULL)
      end
      else if($cast(item_drv, bus_item)) begin
        rw.kind = item_mon_copy.dir == CFS_APB_WRITE? UVM_WRITE : UVM_READ;
        
        rw.addr   = item_mon_copy.addr;
        rw.data   = item_mon_copy.data;
        rw.status = UVM_IS_OK;
        `uvm_info("DRV_BUS2REG",$sformatf("CASTING SUCCESSFUL WITH ITEM_DRV..... ADDR :%0h, DATA : %0h, STATUS : %0s",rw.addr, rw.data, rw.status),UVM_FULL)
      end
      else begin
        `uvm_fatal("ALGORITHM_ISSUE", $sformatf("Class not supported: %0s", bus_item.get_type_name()))
      end
      
    endfunction
    
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
      cfs_apb_item_drv item = cfs_apb_item_drv::type_id::create("item");
      
      void'(item.randomize() with {
        item.dir  == (rw.kind == UVM_WRITE) ? CFS_APB_WRITE : CFS_APB_READ;
        item.data == rw.data;
        item.addr == rw.addr;
      });
      
      return item;
    endfunction
endclass

`endif
