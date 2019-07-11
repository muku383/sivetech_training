
   //---------------------------------------------------------------------------
   // Class: ahb_reg_access_seq
   //---------------------------------------------------------------------------
   
class ahb_reg_access_seq extends uvm_sequence#( ahb_transaction );
   `uvm_object_utils( ahb_reg_access_seq )

   function new( string name = "" );
      super.new( name );
   endfunction: new

   task body();
      ahb_transaction ahb_tx;
      ahb_tx = ahb_transaction::type_id::create( .name( "ahb_tx" ) );
      start_item( ahb_tx );
      //assert( ahb_tx.randomize() );
      assert( ahb_tx.randomize() with{hwrite==1;} );
      ahb_tx.print();
      finish_item( ahb_tx );
   endtask: body
endclass: ahb_reg_access_seq
