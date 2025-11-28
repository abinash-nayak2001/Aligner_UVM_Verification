`ifndef VS_ALG_LEGAL_RX_RANDOM_VSEQS_SV
	`define VS_ALG_LEGAL_RX_RANDOM_VSEQS_SV
	
class vs_alg_legal_rx_random_vseqs extends cfs_algn_virtual_sequence_base;
	`uvm_object_utils(vs_alg_legal_rx_random_vseqs)
	
	rand vs_alg_master_rx_seq seq;
	local int alg_data_width;
	
	function new(string name = "vs_alg_legal_rx_random_vseqs");
		super.new(name);
		seq = vs_alg_master_rx_seq::type_id::create("seq");
		
		seq.item.data_default.constraint_mode(0);
    seq.item.offset_default.constraint_mode(0);
	endfunction
	
	task body();
		seq.set_sequencer(p_sequencer.md_rx_sequencer);
		alg_data_width = 32;
		
		assert(seq.randomize() with {item.data.size() > 0; item.data.size() != 3; item.data.size() <= alg_data_width / 8; item.offset < alg_data_width / 8; item.data.size() + item.offset <= alg_data_width / 8; ((alg_data_width/8)+item.offset)%item.data.size() == 0;}) else
			`uvm_error("RX_SEQ","RANDOMIZATION FAILED");
			
		seq.start(p_sequencer.md_rx_sequencer);
	endtask
	
endclass
	
`endif
