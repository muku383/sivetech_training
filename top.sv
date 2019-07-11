
   //---------------------------------------------------------------------------
   // Module: top
   //---------------------------------------------------------------------------

module top;
   import uvm_pkg::*;

   reg clk,resetn;
   ahb_if     ahb_slave_intf( clk,resetn );
ahb_slave DUT (
              	.hclk(clk), 
		.hreset(resetn), 
		.hwdata(ahb_slave_intf.hwdata), 
		.haddr(ahb_slave_intf.haddr), 
		.hburst(ahb_slave_intf.hburst), 
		.htrans(ahb_slave_intf.htrans), 
		.hwrite(ahb_slave_intf.hwrite), 
		.hsel(ahb_slave_intf.hsel), 
		.hreadyout(ahb_slave_intf.hreadyout), 
		.hrdata(ahb_slave_intf.hrdata)
	//	.w_en_ff(w_en_ff),
	//	.r_en_ff(r_en_ff),
	//	.din(),
	//	.dout(),
	//	.fifo_empty(),
	//	.fifo_full()

               );

initial begin
 resetn=1;
 #20 resetn=0;
 #20 resetn=1;
end

   initial begin
      clk = 0;
      #5ns ;
      forever #5ns clk = ! clk;
   end

   initial begin
      uvm_resource_db#( virtual ahb_if )::set
	( .scope( "ifs" ), .name( "ahb_if" ), .val( ahb_slave_intf ) );
      run_test();
   end
endmodule: top
