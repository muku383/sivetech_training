
`include "uvm_macros.svh"
   import uvm_pkg::*;
   //---------------------------------------------------------------------------
   // Class: ahb_transaction
   //---------------------------------------------------------------------------

class ahb_transaction extends uvm_sequence_item;
	rand bit [31:0] haddr;
	rand bit [31:0] hrdata[];
	rand bit hwrite;
	rand bit [2:0] hburst;
//	bit [2:0] hburst = 'h0;
	rand bit [2:0] hsize;
	bit [1:0] htrans = 'h0;
	rand bit [1:0] hresp;
	rand bit [31:0] hwdata[];
        

	constraint ahb_burst_constraint {
		                  hburst inside {0,1,3,5,7}; 
			  	  if (hburst != (0 || 1))   hwdata.size() == ((hburst+1)*2);
				  else hwdata.size() == 1;
		                  haddr inside {['h00000000 :'h000000FF]} 	
	                           ;}

   //typedef enum bit[1:0] { UNKNOWN, YUMMY, YUCKY } taste_e;

   function new( string name = "ahb_transaction" );
      super.new( name );
   endfunction: new

   `uvm_object_utils_begin( ahb_transaction )
      `uvm_field_int ( htrans,       UVM_ALL_ON )
      `uvm_field_int ( haddr,       UVM_ALL_ON )
      `uvm_field_int ( hwrite,       UVM_ALL_ON )
      `uvm_field_int ( hburst,       UVM_ALL_ON )
      `uvm_field_int ( hsize,             UVM_ALL_ON )
      `uvm_field_int ( hresp,             UVM_ALL_ON )
      `uvm_field_array_int ( hrdata,             UVM_ALL_ON )
      `uvm_field_array_int ( hwdata,             UVM_ALL_ON )
   `uvm_object_utils_end

endclass: ahb_transaction

