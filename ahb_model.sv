
   //---------------------------------------------------------------------------
   // Module: ahb_model
   //   This is the DUT.
   //---------------------------------------------------------------------------

module ahb_model(
    input clk,	
    input [31:0] paddr,
    input        psel,
    input        penable,
    input        pwrite,
    output reg [31:0] prdata,
    input [31:0] pwdata,
    output   reg     pslverr,
    output  reg      pready
 );
reg [31:0] mem [256];
always @(posedge clk)begin
	if(penable && psel)begin
		pready<= 1'b1;
		pslverr<= 1'b0;
		if(pwrite) begin
		 mem[paddr]=pwdata;
		 `uvm_info("APB_MODEL",$sformatf("writing data %0h @%0h",pwdata,paddr),UVM_LOW)
		end else begin
		 prdata = mem[paddr]; 
		 `uvm_info("APB_MODEL",$sformatf("reading data %0h @%0h",mem[paddr],paddr),UVM_LOW)
		end
	end
	else begin
		pready<= 1'b0;
		pslverr<= 1'b0;
	end
end
endmodule: ahb_model
