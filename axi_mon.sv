class axi_mon extends uvm_monitor;
	`uvm_component_utils(axi_mon)

        virtual axi_intf vif;
        uvm_analysis_port#(axi_txn) mon_ap;	

        extern function new(string name="axi_mon",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass	

	function axi_mon::new(string name="axi_mon",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void axi_mon::build_phase(uvm_phase phase);
	        super.build_phase(phase);
		mon_ap = new("mon_ap",this);
		if(!uvm_config_db#(virtual axi_intf)::get(this,"","axi_intf",vif))
			`uvm_error(get_type_name(),$sformatf("DUT interface not found!!!"))
	endfunction

	task axi_mon::run_phase(uvm_phase phase);
	       axi_txn mon_pkt = axi_txn::type_id::create("mon_pkt");
	     //  axi_cov axi_cov_h = new();
               @(vif.mon_cb);
               forever begin
                       fork
	                    begin
	                	    wait(vif.mon_cb.AWVALID && vif.mon_cb.AWREADY);
	                	       mon_pkt.AWADDR   = vif.mon_cb.AWADDR;
	                	       mon_pkt.AWLEN    = vif.mon_cb.AWLEN;
	                	       mon_pkt.AWSIZE   = vif.mon_cb.AWSIZE;
	                	       mon_pkt.AWBURST  = vif.mon_cb.AWBURST;
	                	       mon_pkt.AWVALID  = vif.mon_cb.AWVALID;
	                	       mon_pkt.AWREADY  = vif.mon_cb.AWREADY;    
	                    end
	                    begin
	                	    wait(vif.mon_cb.ARVALID && vif.mon_cb.ARREADY);
	                	       mon_pkt.ARADDR   = vif.mon_cb.ARADDR;
	                	       mon_pkt.ARLEN    = vif.mon_cb.ARLEN;
	                	       mon_pkt.ARSIZE   = vif.mon_cb.ARSIZE;
	                	       mon_pkt.ARBURST  = vif.mon_cb.ARBURST;
	                	       mon_pkt.ARVALID  = vif.mon_cb.ARVALID;
 	                	       mon_pkt.ARREADY  = vif.mon_cb.ARREADY;    
	                    end
	                    begin
	                	    wait(vif.mon_cb.WVALID && vif.mon_cb.WREADY);
	                //	       mon_pkt.WDATA   = vif.mon_cb.WDATA;
	                	       mon_pkt.WLAST   = vif.mon_cb.WLAST;
	                	       mon_pkt.WVALID  = vif.mon_cb.WVALID;
	                	       mon_pkt.WREADY  = vif.mon_cb.WREADY;    
	                    end
	                    begin
	                	    wait(vif.mon_cb.RVALID && vif.mon_cb.RREADY);
	               // 	       mon_pkt.RDATA   = vif.mon_cb.RDATA;
	                	       mon_pkt.RLAST   = vif.mon_cb.RLAST;
	                	       mon_pkt.RRESP   = vif.mon_cb.RRESP;
	                	       mon_pkt.RVALID  = vif.mon_cb.RVALID;
	                	       mon_pkt.RREADY  = vif.mon_cb.RREADY;    
	                    end
	                    begin
	                	    wait(vif.mon_cb.BVALID && vif.mon_cb.BREADY);
	                	       mon_pkt.BRESP   = vif.mon_cb.BRESP;
	                	       mon_pkt.BVALID  = vif.mon_cb.BVALID;
	                	       mon_pkt.BREADY  = vif.mon_cb.BREADY;    
	                    end
                      join	    
            //  axi_cov_h.cov_sample(mon_pkt); 
              mon_ap.write(mon_pkt);
           
           end
	endtask

	
