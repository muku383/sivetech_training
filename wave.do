onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hclk
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hwdata
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/haddr
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hburst
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/htrans
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hwrite
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/din
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/dout
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/r_en_ff
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/w_en_ff
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hsel
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/fifo_empty
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/fifo_full
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hreadyout
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hrdata
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/count
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/current_state
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/next_state
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/saddr
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/slave_busy1
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/num_of_beats
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/last
add wave -noupdate /top/i2c_master_inst0/ahb_slave_inst/hresetn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109719 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {157500 ps}
