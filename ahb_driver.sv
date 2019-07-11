   //---------------------------------------------------------------------------
   // Class: ahb_driver
   //---------------------------------------------------------------------------

class ahb_driver extends uvm_driver#( ahb_transaction );
   `uvm_component_utils( ahb_driver )

int no_transactions;

   virtual ahb_if ahb_vif;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      void'( uvm_resource_db#( virtual ahb_if )::read_by_name
	     ( .scope( "ifs" ), .name( "ahb_if" ), .val( ahb_vif ) ) );
   endfunction: build_phase

   task run_phase( uvm_phase phase );
      ahb_transaction ahb_tx;
      @(posedge ahb_vif.resetn);
      @(ahb_vif.master);
      forever begin
	 seq_item_port.get_next_item( ahb_tx );
		
	 if(ahb_tx.hwrite)
	   drv_write(ahb_tx);
	else
	   drv_read(ahb_tx);

	 seq_item_port.item_done();
      end
   endtask: run_phase

   task reset();
   wait (ahb_vif.resetn);
	  ahb_vif.master.haddr  <= 'b0; 
	  ahb_vif.master.hwrite <= 'b0;
	  ahb_vif.master.hburst <= 'b0;
	  ahb_vif.master.htrans <= 'b0;
	  ahb_vif.master.hsize  <= 'b0;
	 // ahb_vif.master.hreadyout = 'b0;
	  ahb_vif.master.hwdata  <= 'b0;
	  ahb_vif.master.hsel  <= 'b0;
	//  ahb_vif.master.hrdata  = 'b0;
   endtask : reset

   task drv_write(ahb_transaction trans);
   begin
	   int i;
	   bit [5:0] burst_size;
   @ (posedge ahb_vif.master);
  $display (" display %d " , trans.haddr);
  ahb_vif.master.hsel  <= 'b1;
  ahb_vif.master.haddr  <= trans.haddr;
  ahb_vif.master.hwrite <= 'b1;
  ahb_vif.master.hburst <= trans.hburst;
  ahb_vif.master.htrans <= trans.htrans;
  ahb_vif.master.hsize  <= trans.hsize;
  	case(trans.hburst)
       	3'd2 : burst_size = 4;
       	3'd3 : burst_size = 4;
       	3'd4 : burst_size = 8;
       	3'd5 : burst_size = 8;
       	3'd6 : burst_size = 16;
       	3'd7 : burst_size = 16;
       	default : burst_size = 1;
       endcase
 $display($time," burst_size = %d", burst_size);
           begin
           for (i=0; i < burst_size ; i=i+1 )
           begin
 $display($time," for loop i = %d", i);
                   ahb_vif.master.haddr  <= trans.haddr +'d4;
		   if (i==0)
                   ahb_vif.master.htrans <= 'h2;
	   	   else 
                   ahb_vif.master.htrans <= 'h3;
        	   @(posedge ahb_vif.master)
                   wait ( ahb_vif.master.hreadyout);
 $display($time," hwdata[%d]1 = %d", i,trans.hwdata[i]);
                   ahb_vif.master.hwdata <= trans.hwdata[i];
 $display($time," hwdata[%d]2 = %d", i, trans.hwdata[i]);
           end
   end
        	   @(posedge ahb_vif.master)
                   ahb_vif.master.htrans <= 'h0;
                   ahb_vif.master.hsel  <= 'b0;
         end
   endtask : drv_write;

   ///////////////////////write-end/////////////

   task drv_read(ahb_transaction trans);
   begin
    int i;
    bit [3:0] burst_size;
    @ (posedge ahb_vif.master);
   ahb_vif.master.hsel  <= 'b1;
   ahb_vif.master.haddr  <= trans.haddr;
   ahb_vif.master.hwrite <= 'b0;
   ahb_vif.master.hburst <= trans.hburst;
   ahb_vif.master.htrans <= trans.htrans;
   ahb_vif.master.hsize  <= trans.hsize;
  	case(trans.hburst)
       	3'd2 : burst_size = 4;
       	3'd3 : burst_size = 4;
       	3'd4 : burst_size = 8;
       	3'd5 : burst_size = 8;
       	3'd6 : burst_size = 16;
       	3'd7 : burst_size = 16;
       	default : burst_size = 1;
       endcase
 $display($time," burst_size = %d", burst_size);
           for (i=0; i < burst_size ; i=i+1 )
           begin
		   if (i==0)
		   begin
                   ahb_vif.master.htrans <= 'h2;
                   ahb_vif.master.haddr  <= trans.haddr +'d4;
	           end
	   	   else
		   begin 
                   ahb_vif.master.htrans <= 'h3;
                   ahb_vif.master.haddr  <= trans.haddr +'d4;
	           end
        	   @(posedge ahb_vif.master)
                   wait ( ahb_vif.master.hreadyout);
                   trans.hrdata[i] = ahb_vif.master.hrdata;
           end
        	   @(posedge ahb_vif.master)
                   ahb_vif.master.htrans <= 'h0;
                   ahb_vif.master.hsel  <= 'b0;
         end
   endtask : drv_read;
   //////////////////read-end///////////// 
endclass: ahb_driver
