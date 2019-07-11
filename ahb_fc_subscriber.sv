class ahb_fc_subscriber extends uvm_subscriber#( ahb_transaction );
   `uvm_component_utils( ahb_fc_subscriber )

   ahb_transaction txn;


   covergroup ahb_cg;
      hwrite : coverpoint txn.hwrite;
      htrans : coverpoint txn.htrans;
      hburst : coverpoint txn.hburst;
      hsize  : coverpoint txn.hsize;
      haddr  : coverpoint txn.haddr;

	   
      cross hburst,hsize,htrans,hwrite;
   endgroup: ahb_cg


   function new( string name, uvm_component parent );
      super.new( name, parent );

      ahb_cg = new;

   endfunction: new

   function void write( ahb_transaction t );
      txn = t;

      ahb_cg.sample();

   endfunction: write
endclass: ahb_fc_subscriber


