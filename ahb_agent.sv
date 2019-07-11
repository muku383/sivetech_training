
   //---------------------------------------------------------------------------
   // Class: ahb_agent
   //---------------------------------------------------------------------------

class ahb_agent extends uvm_agent;
   `uvm_component_utils( ahb_agent )

   uvm_analysis_port#( ahb_transaction ) ahb_ap;
     
   ahb_sequencer ahb_seqr;
   ahb_driver    ahb_drvr;
   ahb_monitor   ahb_mon;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );

      ahb_ap = new( .name( "ahb_ap" ), .parent( this ) );
      ahb_seqr = ahb_sequencer::type_id::create( .name( "ahb_seqr" ), .parent( this ) );
      ahb_drvr = ahb_driver   ::type_id::create( .name( "ahb_drvr" ), .parent( this ) );
     ahb_mon  = ahb_monitor  ::type_id::create( .name( "ahb_mon"  ), .parent( this ) );
   endfunction: build_phase

   function void connect_phase( uvm_phase phase );
      super.connect_phase( phase );
      ahb_drvr.seq_item_port.connect( ahb_seqr.seq_item_export );
      ahb_mon.ahb_ap.connect( ahb_ap );
   endfunction: connect_phase
endclass: ahb_agent

