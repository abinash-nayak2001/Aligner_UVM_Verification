`ifndef VS_ALG_LEGAL_REG_RX_TEST_SV
	`define VS_ALG_LEGAL_REG_RX_TEST_SV
	
	class vs_alg_legal_reg_rx_test extends cfs_algn_test_base;
		`uvm_component_utils(vs_alg_legal_reg_rx_test)
		
		vs_alg_legal_config_random_vseqs reg_config_seq;
		cfs_md_sequence_slave_response_forever tx_seq;
		//
		cfs_md_sequence_simple_master rx_seq;
		//
		cfs_algn_seq_reg_config seq1;
		int unsigned no_of_trans = 1;
		
		function new(string name = "vs_alg_legal_reg_rx_test", uvm_component parent = null);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		endfunction
		
		task run_phase(uvm_phase phase);
			phase.raise_objection(this, "TEST_DONE");
			
			#50;
			fork
				begin
					tx_seq = cfs_md_sequence_slave_response_forever::type_id::create("tx_seq");
					tx_seq.start(env.md_tx_agent.sequencer);
				end
			join_none
			
			repeat(no_of_trans)
			begin
				reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");
				reg_config_seq.block = env.model.reg_block;
			
				reg_config_seq.start(env.virtual_sequencer);
				//
				rx_seq = cfs_md_sequence_simple_master::type_id::create("rx_seq");
				repeat(10)
				begin
					rx_seq.start(env.md_rx_agent.sequencer);
				end
				//
				#50;
			end
			
			phase.phase_done.set_drain_time(this,500);
			phase.drop_objection(this, "TEST_DONE");
		endtask
	endclass
	
`endif
