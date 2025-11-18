`ifndef VS_ALG_EMPTY_TX_VSEQS_SV
	`define VS_ALG_EMPTY_TX_VSEQS_SV
	
class vs_alg_empty_tx_vseqs extends cfs_algn_virtual_sequence_base;
	`uvm_object_utils(vs_alg_empty_tx_vseqs)
	
	cfs_md_sequence_simple_slave seq;
	
	function new(string name = "vs_alg_empty_tx_vseqs");
		super.new(name);
	endfunction
	
	task body();
		cfs_md_item_mon item_mon;
		p_sequencer.md_tx_sequencer.pending_items.get(item_mon);
		
		seq = cfs_md_sequence_simple_slave::type_id::create("seq");
		seq.set_sequencer(p_sequencer.md_tx_sequencer);
		
		seq.start(p_sequencer.md_tx_sequencer);
	endtask
endclass
		
`endif
