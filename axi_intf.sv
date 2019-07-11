`timescale 1ns/1ps
interface axi_intf(input logic ACLK);
        
   logic ARESETn;
   
// Write Address Channel
   logic [3:0]  AWID;
   logic [31:0] AWADDR;
   logic [3:0]  AWLEN;
   logic [2:0]  AWSIZE;
   logic [1:0]  AWBURST;
   logic        AWVALID;
   logic        AWREADY;
 
// Write Data Channel
   logic [3:0]  WID;
   logic [31:0] WDATA;
   logic [3:0]  WSTRB;
   logic        WLAST;
   logic        WVALID;
   logic        WREADY;
    
// Write Response Channel
   logic [3:0]  BID;
   logic [1:0]  BRESP;
   logic        BVALID;
   logic        BREADY;

// Read Address Channel 
   logic [3:0]  ARID;
   logic [31:0] ARADDR;
   logic [3:0]  ARLEN;
   logic [2:0]  ARSIZE;
   logic [1:0]  ARBURST;
   logic        ARVALID;
   logic        ARREADY;
                             
 // Read Data Channel     
    logic [3:0]  RID;     
    logic [31:0] RDATA;
    logic [1:0]  RRESP;
    logic        RLAST;
    logic        RVALID;
    logic        RREADY;

    clocking mon_cb@(posedge ACLK);
          default input #1 output #0;
          
          input ARESETn;
          
          input AWID;
          input AWADDR;
          input AWLEN;
          input AWSIZE;
          input AWBURST;
          input AWVALID;
          input AWREADY;
          
          input WID;
          input WDATA;
          input WSTRB;
          input WLAST;
          input WVALID;
          input WREADY;
          
          input BID;
          input BRESP;
          input BVALID;
          input BREADY;
          
          input ARID;
          input ARADDR;
          input ARLEN;
          input ARSIZE;
          input ARBURST;
          input ARVALID;
          input ARREADY;
          
          input RID;     
          input RDATA;
          input RRESP;
          input RLAST;
          input RVALID;
          input RREADY;
      
    endclocking

    clocking drv_cb@(posedge ACLK);
          default input #1 output #0;
         
          output ARESETn;
      
          output AWID;
          output AWADDR;
          output AWLEN;
          output AWSIZE;
          output AWBURST;
          output AWVALID;
          input  AWREADY;
          
          output WID;
          output WDATA;
          output WSTRB;
          output WLAST;
          output WVALID;
          input  WREADY;
          
          input  BID;
          input  BRESP;
          input  BVALID;
          output BREADY;
          
          output ARID;
          output ARADDR;
          output ARLEN;
          output ARSIZE;
          output ARBURST;
          output ARVALID;
          input  ARREADY;
          
          input  RID;     
          input  RDATA;
          input  RRESP;
          input  RLAST;
          input  RVALID;
          output RREADY;
      
    endclocking

    modport mon_mp(clocking mon_cb, input ARESETn);
    modport drv_mp(clocking drv_cb, output ARESETn);

endinterface






