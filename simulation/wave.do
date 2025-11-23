onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group APB_IF /top/apb_if/pclk
add wave -noupdate -group APB_IF /top/apb_if/preset_n
add wave -noupdate -group APB_IF /top/apb_if/paddr
add wave -noupdate -group APB_IF /top/apb_if/pwrite
add wave -noupdate -group APB_IF /top/apb_if/psel
add wave -noupdate -group APB_IF /top/apb_if/penable
add wave -noupdate -group APB_IF /top/apb_if/pwdata
add wave -noupdate -group APB_IF /top/apb_if/pready
add wave -noupdate -group APB_IF /top/apb_if/prdata
add wave -noupdate -group APB_IF /top/apb_if/pslverr
add wave -noupdate -group APB_IF /top/apb_if/has_checks
add wave -noupdate -group MD_RX_IF /top/md_rx_if/clk
add wave -noupdate -group MD_RX_IF /top/md_rx_if/reset_n
add wave -noupdate -group MD_RX_IF /top/md_rx_if/valid
add wave -noupdate -group MD_RX_IF /top/md_rx_if/data
add wave -noupdate -group MD_RX_IF /top/md_rx_if/offset
add wave -noupdate -group MD_RX_IF /top/md_rx_if/size
add wave -noupdate -group MD_RX_IF /top/md_rx_if/ready
add wave -noupdate -group MD_RX_IF /top/md_rx_if/err
add wave -noupdate -group MD_RX_IF /top/md_rx_if/has_checks
add wave -noupdate -group MD_TX_IF /top/md_tx_if/clk
add wave -noupdate -group MD_TX_IF /top/md_tx_if/reset_n
add wave -noupdate -group MD_TX_IF /top/md_tx_if/valid
add wave -noupdate -group MD_TX_IF /top/md_tx_if/data
add wave -noupdate -group MD_TX_IF /top/md_tx_if/offset
add wave -noupdate -group MD_TX_IF /top/md_tx_if/size
add wave -noupdate -group MD_TX_IF /top/md_tx_if/ready
add wave -noupdate -group MD_TX_IF /top/md_tx_if/err
add wave -noupdate -group MD_TX_IF /top/md_tx_if/has_checks
add wave -noupdate -group ALGN_IF /top/algn_if/clk
add wave -noupdate -group ALGN_IF /top/algn_if/reset_n
add wave -noupdate -group ALGN_IF /top/algn_if/irq
add wave -noupdate -group ALGN_IF /top/algn_if/rx_fifo_push
add wave -noupdate -group ALGN_IF /top/algn_if/rx_fifo_pop
add wave -noupdate -group ALGN_IF /top/algn_if/tx_fifo_push
add wave -noupdate -group ALGN_IF /top/algn_if/tx_fifo_pop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {685 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
configure wave -valuecolwidth 85
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1519 ns}
