vlib work
#vlog -sv +cover ../../i2c_ip_vip/i2c_ip/i2c_ip_only.svh +incdir+../../i2c_ip_vip/i2c_ip/ -l i2c_comp_log
#vlog -sv +cover ../../uvm_apb_tb/apb_uvm/apb_uvm/compile_apb_agent.svh +incdir+../../uvm_apb_tb/apb_uvm/apb_uvm/ -l apb_comp_log
#vlog -sv +cover -l i2c_s_comp_log i2c_slave_comp.svh
vlog -sv +cover ahb_all.svh -l comp_log
