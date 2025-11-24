///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_pkg.sv
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Environment package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_PKG_SV
  `define CFS_ALGN_PKG_SV

  package cfs_algn_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import uvm_ext_pkg::*;
    import cfs_apb_pkg::*;
    import cfs_md_pkg::*;
    import cfs_algn_reg_pkg::*;

    `include "cfs_algn_types.sv"
    `include "cfs_algn_env_config.sv"
    `include "cfs_algn_clr_cnt_drop.sv"
    `include "cfs_algn_split_info.sv"
    `include "cfs_algn_model.sv"
    `include "cfs_algn_coverage.sv"
    `include "cfs_algn_reg_access_status_info.sv"
    `include "cfs_algn_reg_predictor.sv"
    `include "cfs_algn_scoreboard.sv"
    `include "cfs_algn_virtual_sequencer.sv"
    `include "cfs_algn_env.sv"

    `include "cfs_algn_seq_reg_config.sv"

    `include "cfs_algn_virtual_sequence_base.sv"
    `include "cfs_algn_virtual_sequence_slow_pace.sv"
    `include "cfs_algn_virtual_sequence_reg_access_random.sv"
    `include "cfs_algn_virtual_sequence_reg_access_unmapped.sv"
    `include "cfs_algn_virtual_sequence_reg_config.sv"
    `include "cfs_algn_virtual_sequence_reg_status.sv"
    `include "cfs_algn_virtual_sequence_rx.sv"
    `include "cfs_algn_virtual_sequence_rx_err.sv"
    
    `include "vs_alg_legal_config_random_vseqs.sv"
    `include "vs_alg_legal_rx_random_vseqs.sv"
    `include "vs_alg_empty_tx_vseqs.sv"
    `include "vs_alg_no_addr_vseqs.sv"
    `include "vs_alg_no_acc_vseqs.sv"
    `include "vs_alg_illegal_config_vseqs.sv"

  endpackage

`endif
