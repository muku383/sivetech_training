
   //---------------------------------------------------------------------------
   // Class: ahb_env
   //---------------------------------------------------------------------------

class ahb_env extends uvm_env;
   `uvm_component_utils( ahb_env )

   ahb_agent         ahb_agent0;
   ahb_fc_subscriber ahb_fc_sub;
   //ahb_scoreboard    ahb_sb;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      ahb_agent0  = ahb_agent::type_id::create( .name( "ahb_agent"  ), .parent( this ) );
      ahb_fc_sub = ahb_fc_subscriber::type_id::create( .name( "ahb_fc_sub" ), .parent( this ) );
      //ahb_sb     = ahb_scoreboard   ::type_id::create( .name( "ahb_sb"     ), .parent( this ) );
    endfunction: build_phase

   function void connect_phase( uvm_phase phase );
      super.connect_phase( phase );
      ahb_agent0.ahb_ap.connect( ahb_fc_sub.analysis_export );
      //ahb_agent.ahb_ap.connect( ahb_sb.ahb_analysis_export );
   endfunction: connect_phase
endclass: ahb_env
