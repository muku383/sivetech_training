`timescale 1ns/1ns

module axi_top;
   
     import uvm_pkg::*;
     import axi_test_pkg::*;

     bit reset,clock='b1;

     always #5 clock = ~clock;
     
/*     initial begin
              reset = 'b0;
         #11  reset = 'b1; 
     end
*/
//     axi_intf intf(clock,reset);
     axi_intf intf(clock);
     axi_lite_slave dut(  
                        .ACLK(clock),
                        .ARESETN(intf.ARESETn),  
//                        .ARESETN(reset),  
                        
                        .S_AXI_AWADDR(intf.AWADDR),                           
                        .S_AXI_AWID(intf.AWID),
                        .S_AXI_AWPROT(),
                        .S_AXI_AWVALID(intf.AWVALID),
                        .S_AXI_AWLEN(intf.AWLEN),
                        .S_AXI_AWSIZE(intf.AWSIZE),
                        .S_AXI_ARSIZE(intf.ARSIZE),
                        .S_AXI_AWBURST(intf.AWBURST),
                        .S_AXI_ARBURST(intf.ARBURST),
                        .S_AXI_AWREADY(intf.AWREADY),
                      
                        .S_AXI_WID(intf.WID),
                        .S_AXI_WDATA(intf.WDATA),
                        .S_AXI_WSTRB(intf.WSTRB),
                        .S_AXI_WVALID(intf.WVALID),
                        .S_AXI_WLAST(intf.WLAST),
                        .S_AXI_WREADY(intf.WREADY),

                        .S_AXI_BID(intf.BID),
                        .S_AXI_BRESP(intf.BRESP),
                        .S_AXI_BVALID(intf.BVALID),
                        .S_AXI_BREADY(intf.BREADY),

                        .S_AXI_ARID(intf.ARID),
                        .S_AXI_ARADDR(intf.ARADDR),
                        .S_AXI_ARPROT(),
                        .S_AXI_ARVALID(intf.ARVALID),
                        .S_AXI_ARLEN(intf.ARLEN),
                        .S_AXI_ARREADY(intf.ARREADY),
 
                        .S_AXI_RID(intf.RID),
                        .S_AXI_RDATA(intf.RDATA),
                        .S_AXI_RRESP(intf.RRESP),
                        .S_AXI_RVALID(intf.RVALID),
                        .S_AXI_RREADY(intf.RREADY),
                        .S_AXI_RLAST(intf.RLAST)

                     );

     initial begin
           uvm_config_db#(virtual axi_intf)::set(null,"*","axi_intf",intf);
        // run_test("incr_test");      
           run_test();      
     end

     initial begin  #10000 $finish(); 
     end     


endmodule
