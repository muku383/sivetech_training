   //---------------------------------------------------------------------------
   // Class: ahb_base_test
   //---------------------------------------------------------------------------

class ahb_base_test extends uvm_test;
   `uvm_component_utils( ahb_base_test )

   ahb_env ahb_env0;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      begin
	 //ahb_configuration ahb_cfg;

	 //ahb_cfg = new;
	 //assert( ahb_cfg.randomize() );
	 //uvm_config_db#( ahb_configuration )::set
	 //  ( .cntxt( this ), .inst_name( "*" ), .field_name( "config" ), .value( ahb_cfg ) );
	 
	 //ahb_transaction::type_id::set_type_override
	 //  ( sugar_free_ahb_transaction::get_type() );

	 ahb_env0 = ahb_env::type_id::create( .name( "ahb_env" ), .parent( this ) );
      end
   endfunction: build_phase

   task run_phase( uvm_phase phase );
      ahb_reg_access_seq ahb_seq;

      phase.raise_objection( .obj( this ) );
      ahb_seq = ahb_reg_access_seq::type_id::create( .name( "ahb_seq" ) );
      assert( ahb_seq.randomize() );
      `uvm_info( "ahb_base_test", { "\n", ahb_seq.sprint() }, UVM_LOW )
      ahb_seq.start( ahb_env0.ahb_agent0.ahb_seqr );
      #10ns ;
      phase.drop_objection( .obj( this ) );
   endtask: run_phase

      virtual function void end_of_elaboration_phase (uvm_phase phase);
         uvm_top.print_topology ();
      endfunction
   
endclass: ahb_base_test
