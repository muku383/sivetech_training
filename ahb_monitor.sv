class ahb_monitor extends uvm_monitor;
   `uvm_component_utils( ahb_monitor )

   uvm_analysis_port#( ahb_transaction ) ahb_ap;

   virtual ahb_if ahb_intf;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      void'( uvm_resource_db#( virtual ahb_if )::read_by_name
	     ( .scope( "ifs" ), .name( "ahb_if" ), .val( ahb_intf ) ) );
      ahb_ap = new( .name( "ahb_ap" ), .parent( this ) );
   endfunction: build_phase

   task run_phase( uvm_phase phase );
//	 if ( ahb_intf.slave_cb.flavor != ahb_transaction::NO_FLAVOR ) begin
//	    ahb_monitor_txn.flavor     = ahb_transaction::flavor_e'( ahb_intf.slave_cb.flavor );
//	    ahb_monitor_txn.color      = ahb_transaction::color_e' ( ahb_intf.slave_cb.color  );
//	    ahb_monitor_txn.sugar_free = ahb_intf.slave_cb.sugar_free;
//	    ahb_monitor_txn.sour       = ahb_intf.slave_cb.sour;
//	    @ahb_intf.master_cb;
//	    ahb_monitor_txn.taste = ahb_transaction::taste_e'( ahb_intf.master_cb.taste );
//	    ahb_ap.write( ahb_monitor_txn );
//	 end
	 
		  int i;
		  bit [5:0] burst_size;
		 begin
		   forever
	            begin
		 //        AHB_TRANSACTION ahb_monitor_txn;
	 ahb_transaction ahb_monitor_txn;
	    ahb_monitor_txn = ahb_transaction::type_id::create( .name( "ahb_monitor_ahb_monitor_txn" ) );
	//	         ahb_monitor_txn = new();
		      @ (posedge ahb_intf.monitor);
		       if((ahb_intf.monitor.hsel=='b1 ) && ( ahb_intf.monitor.hwrite=='b1)) 
		        begin
		         ahb_monitor_txn.haddr   = ahb_intf.monitor.haddr;
		         ahb_monitor_txn.hburst   = ahb_intf.monitor.hburst;

			  case(ahb_intf.monitor.hburst)
				3'd2 : burst_size = 4;
				3'd3 : burst_size = 4;
				3'd4 : burst_size = 8;
				3'd5 : burst_size = 8;
				3'd6 : burst_size = 16;
				3'd7 : burst_size = 16;
				default : burst_size = 1;
           		   endcase

			     wait (ahb_intf.monitor.hreadyout);
			     for (i=0; i < burst_size; i= i+1)
			     begin
			     @ (posedge ahb_intf.monitor);
			     ahb_monitor_txn.hwdata[i]   = ahb_intf.monitor.hwdata; 
			     end
		           $display(" write MONITOR",);
	                end
		           //  ahb_monitor_txn.display(); 
		       else
		        if((ahb_intf.monitor.hsel=='b1 ) && ( ahb_intf.monitor.hwrite=='b0)) 
		        begin
		         ahb_monitor_txn.haddr   = ahb_intf.monitor.haddr;
		         ahb_monitor_txn.hburst   = ahb_intf.monitor.hburst;

			  case(ahb_intf.monitor.hburst)
				3'd2 : burst_size = 4;
				3'd3 : burst_size = 4;
				3'd4 : burst_size = 8;
				3'd5 : burst_size = 8;
				3'd6 : burst_size = 16;
				3'd7 : burst_size = 16;
				default : burst_size = 1;
           		   endcase

			     wait (ahb_intf.monitor.hreadyout);
			     for (i=0; i < burst_size; i= i+1)
			     begin
			     @ (posedge ahb_intf.monitor);
			     ahb_monitor_txn.hrdata[i]   = ahb_intf.monitor.hrdata; 
			     end
	                end
			ahb_monitor_txn.print();
	    ahb_ap.write( ahb_monitor_txn );

		     end
	            end


   endtask: run_phase
endclass: ahb_monitor
