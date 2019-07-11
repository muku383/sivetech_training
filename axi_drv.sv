class axi_drv extends uvm_driver#(axi_txn);
	`uvm_component_utils(axi_drv)

	virtual axi_intf vif;
        int count_r = 0;
        int j = 0;

        extern function new(string name="axi_drv",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task write_drive(axi_txn pkt);
	extern task read_drive(axi_txn pkt);
	extern task wa_drive(axi_txn pkt);        // Write address drive
	extern task wd_drive(axi_txn pkt);        // Write data drive
	extern task w_resp_drive(axi_txn pkt);        // Write data drive
	extern task ra_drive(axi_txn pkt);        // Read address drive
	extern task rd_drive(axi_txn pkt);        // Read data drive

endclass

  function axi_drv::new(string name="axi_drv",uvm_component parent);
	  super.new(name,parent);
  endfunction

 function void axi_drv::build_phase(uvm_phase phase);
	super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_intf)::get(this,"","axi_intf",vif))
	    `uvm_fatal(get_full_name(),"Cannot get VIF from configuration database!!!")	
 endfunction

 task axi_drv::run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
         `uvm_info(get_type_name(),$sformatf("Waiting for data from sequencer"),UVM_MEDIUM)
         seq_item_port.get_next_item(req);
           write_drive(req);
	   read_drive(req);
	 seq_item_port.item_done();     
     end
 endtask

 task axi_drv::write_drive(axi_txn pkt);
        $display($time, "write_drive task starting");
         wa_drive(pkt);
         wd_drive(pkt);
    //     w_resp_drive(pkt);
        $display($time, "write_drive task ending");
 endtask

 task axi_drv::wa_drive(axi_txn pkt);
         @(vif.drv_cb);
	 if(!pkt.ARESETn)          //If Reset Active
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
		 vif.drv_cb.AWADDR  <= 0;  
		 vif.drv_cb.AWLEN   <= 0; 
		 vif.drv_cb.AWSIZE  <= 0; 
		 vif.drv_cb.AWBURST <= 0; 
		 vif.drv_cb.AWVALID <= 0; 
	   end	 
	   
	 else                    //If Reset InActive
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
		 vif.drv_cb.AWADDR  <= pkt.AWADDR;
		 vif.drv_cb.AWLEN   <= pkt.AWLEN;
		 vif.drv_cb.AWSIZE  <= pkt.AWSIZE;
		 vif.drv_cb.AWBURST <= pkt.AWBURST;
		// vif.drv_cb.AWVALID <= pkt.AWVALID;
		 vif.drv_cb.AWVALID <= 'b1;
		 wait(vif.drv_cb.AWREADY);
                  @(vif.drv_cb);
     		 vif.drv_cb.AWVALID  <= 0; 
	   end
 endtask

 task axi_drv::wd_drive(axi_txn pkt);
         int count_w=0;                // counts number of beats
	// @(vif.drv_cb);
	 if(!pkt.ARESETn)            // If Reset Active
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
		 vif.drv_cb.WDATA   <= 0;  
		 vif.drv_cb.WLAST   <= 0; 
		 vif.drv_cb.WVALID  <= 0; 
	   end	 
	   
	   else begin                // If Reset InActive
	         foreach(pkt.WDATA[i])
	           begin
                       vif.drv_cb.ARESETn <= pkt.ARESETn;
     		       vif.drv_cb.WDATA   <= pkt.WDATA[i];  
     		       vif.drv_cb.WVALID  <= 1; 
     		       if(count_w == pkt.AWLEN) 
			       vif.drv_cb.WLAST   <= 1;
		       else    vif.drv_cb.WLAST   <= 0;
                       //wait(vif.drv_cb.WREADY);
                       while(vif.drv_cb.WREADY== 0) @(vif.drv_cb);
                       count_w++;
                       @(vif.drv_cb);
     		       vif.drv_cb.WVALID  <= 0; 
     		       vif.drv_cb.WLAST   <= 0; 
 
                    // $display($time, "value for count = %d, pkt_size = %d, i=%d, AWLEN = %d ", count_w , pkt.WDATA.size , i , pkt.AWLEN);
		       @(vif.drv_cb);
		   end	   
	   end
         
   // Logic for write response channel
//	 @(vif.drv_cb);
         $display($time,"ENTERINGGGGGGGGGGGGGGGGGGGG");
	 if(!pkt.ARESETn)              // If Reset Active
	   begin   
                 $display($time,"RESET ACTIVEEEEEEEEE");
		// vif.drv_cb.ARESETn <= pkt.ARESETn;
     		 vif.drv_cb.BREADY  <= 'd0;
		 pkt.BRESP          = 'd0 ; 
		 pkt.BVALID         = 'd0 ; 
	   end	 
	   
	   else begin                // If Reset InActive
     		    //   vif.drv_cb.ARESETn <= pkt.ARESETn;
                       $display($time,"RESET DE---ACTIVEEEEEEEEE STARTINGGGGG ");
     		       vif.drv_cb.BREADY  <= 1'b1;
           	       pkt.BRESP          = vif.drv_cb.BRESP  ; 
           	       pkt.BVALID         = vif.drv_cb.BVALID ; 
                       
                       while(vif.drv_cb.BVALID == 0) @(vif.drv_cb);
     		       
                 	 @(vif.drv_cb);
                         vif.drv_cb.BREADY  <= 1'b0;
                 	 @(vif.drv_cb);
                       $display($time,"RESET DE---ACTIVEEEEEEEEE ENDINGGGGGGG ");
	       end
         $display($time,"EXITINGGGGGGGGGGGGGGGGGGGGG");

 endtask

 task axi_drv::w_resp_drive(axi_txn pkt);
	 @(vif.drv_cb);
         $display("ENTERINGGGGGGGGGGGGGGGGGGGG");
	 if(!pkt.ARESETn)              // If Reset Active
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
     		 vif.drv_cb.BREADY  <= 'd0;
		 pkt.BRESP          = 'd0 ; 
		 pkt.BVALID         = 'd0 ; 
	   end	 
	   
	   else begin                // If Reset InActive
     		       vif.drv_cb.ARESETn <= pkt.ARESETn;
     		       vif.drv_cb.BREADY  <= 'd0;
           	       pkt.BRESP          = vif.drv_cb.BRESP  ; 
           	       pkt.BVALID         = vif.drv_cb.BVALID ; 
                       
                       while(vif.drv_cb.BVALID == 0) @(vif.drv_cb);
     		       vif.drv_cb.BREADY  <= 'd1;
                 	 @(vif.drv_cb);
     		       vif.drv_cb.BREADY  <= 'd0;
                 	 @(vif.drv_cb);
	       end
         $display("EXITINGGGGGGGGGGGGGGGGGGGGG");
 endtask


 task axi_drv::read_drive(axi_txn pkt);
         $display($time, "read_drive task starting");
         ra_drive(pkt);
         rd_drive(pkt);
        $display($time, "read_drive task ending");
 endtask

 task axi_drv::ra_drive(axi_txn pkt);
         @(vif.drv_cb);
	 if(!pkt.ARESETn)          //If Reset Active
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
		 vif.drv_cb.ARADDR  <= 0;  
		 vif.drv_cb.ARLEN   <= 0; 
		 vif.drv_cb.ARSIZE  <= 0; 
		 vif.drv_cb.ARBURST <= 0; 
		 vif.drv_cb.ARVALID <= 0; 
	   end	 
	   
	 else                    //If Reset InActive
	   begin   
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
		 vif.drv_cb.ARADDR  <= pkt.ARADDR;
		 vif.drv_cb.ARLEN   <= pkt.ARLEN;
		 vif.drv_cb.ARSIZE  <= pkt.ARSIZE;
		 vif.drv_cb.ARBURST <= pkt.ARBURST;
	//	 vif.drv_cb.ARVALID <= pkt.ARVALID;
		 vif.drv_cb.ARVALID <= 'b1;
		 while(vif.drv_cb.ARREADY == 0)  @(vif.drv_cb);
		 vif.drv_cb.ARVALID <= 'b0;
                $display($time, "ra_drive task");

 	   end
 endtask

 task axi_drv::rd_drive(axi_txn pkt);
          $display($time, "rd_drive task reset_1");
          count_r = 0;                // counts number of beats
    //     pkt.RDATA = new[pkt.ARLEN + 1];
	 @(vif.drv_cb);
	 if(!pkt.ARESETn)              // If Reset Active
	   begin   
                $display($time, "rd_drive task reset");
		 vif.drv_cb.ARESETn <= pkt.ARESETn;
     		 vif.drv_cb.RREADY  <= 'd0;
		 pkt.RDATA[0]       = 'd0 ;  
		 pkt.RLAST          = 'd0 ; 
		 pkt.RRESP          = 'd0 ; 
		 pkt.RVALID         = 'd0 ; 
	         @(vif.drv_cb);
	   end	 
	   
	 else begin                // If Reset InActive
                       count_r = 3;
	       /*  for(j=0;j <= pkt.ARLEN; j++)
	           begin
                       ++count_r;
                       $display($time, "rd_drive task_starting");
     		       vif.drv_cb.ARESETn <= pkt.ARESETn;
     		       vif.drv_cb.RREADY  <= 1;
                       //  @(vif.drv_cb);
           	       pkt.RDATA[j]       = vif.drv_cb.RDATA  ;  
           	       pkt.RLAST          = vif.drv_cb.RLAST  ; 
           	       pkt.RRESP          = vif.drv_cb.RRESP  ; 
           	       pkt.RVALID         = vif.drv_cb.RVALID ; 
                       
                       while(vif.drv_cb.RVALID == 0) @(vif.drv_cb);
     		         
                         @(vif.drv_cb);
                         $display($time, "rd_drive task_ending, j = %d",j);
     		      
                     //  if(vif.drv_cb.RLAST ==  1);

     		   end : for_loop_end
	         */              
     		       vif.drv_cb.ARESETn <= pkt.ARESETn;
     		       vif.drv_cb.RREADY  <= 1;
                   //  if(j ==  pkt.ARLEN);
                     wait(vif.drv_cb.RLAST);
                      //  begin
                              $display($time, "Due to thisssssssssss, j = %d",j);
                      //        @(vif.drv_cb);
                              vif.drv_cb.RREADY  <= 0;
                      //  end 

                         @(vif.drv_cb);
                         @(vif.drv_cb);
                         @(vif.drv_cb);
                         $display($time, "rd_drive task_final_ending");
	   end
 endtask
