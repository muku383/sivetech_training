/*`include "uvm_macros.svh"
   import uvm_pkg::*;*/
class axi_txn extends uvm_sequence_item;
  `uvm_object_utils(axi_txn)

   bit ARESETn = 'b1;
   
// Write Address Channel
   rand bit [3:0]  AWID;
   rand bit [31:0] AWADDR;
   rand bit [3:0]  AWLEN;
   rand bit [2:0]  AWSIZE;
   rand bit [1:0]  AWBURST;
   rand bit        AWVALID;
        bit        AWREADY;
 
// Write Data Channel
   rand bit [3:0]  WID;
   rand bit [31:0] WDATA[];
   rand bit [3:0]  WSTRB;
        bit        WLAST;
   rand bit        WVALID;
        bit        WREADY;
    
// Write Response Channel
   rand bit [3:0]  BID;
        bit [1:0]  BRESP;
        bit        BVALID;
  // rand bit        BREADY;
        bit        BREADY;

// Read Address Channel 
   rand bit [3:0]  ARID;
   rand bit [31:0] ARADDR;
   rand bit [3:0]  ARLEN;
   rand bit [2:0]  ARSIZE;
   rand bit [1:0]  ARBURST;
   rand bit        ARVALID;
        bit        ARREADY;
                             
 // Read Data Channel     
    rand bit [3:0]  RID;     
         bit [31:0] RDATA[];
         bit [1:0]  RRESP;
         bit        RLAST;
         bit        RVALID;
   // rand bit        RREADY;
     bit        RREADY;
              
   constraint id{  AWID == WID == BID;
                   ARID == RID;
                }

   constraint data_width{
                   ARSIZE < 'd3;
                   AWSIZE < 'd3; 
                        }

   constraint w_wrap_add{       if(AWBURST == 'd2)
                                ((AWLEN == 'd1) || (AWLEN == 'd3) || (AWLEN == 'd7) || (AWLEN == 'd15));                 
                        }
   
   constraint r_wrap_add{       if(ARBURST == 'd2)
                                ((ARLEN == 'd1) || (ARLEN == 'd3) || (ARLEN == 'd7) || (ARLEN == 'd15));                 
                        }
   
   constraint burst{ (AWBURST != 'd3) && (ARBURST != 'd3);  
                   }
  
   constraint num_of_beats{
                            WDATA.size == AWLEN + 1;
                        //  RDATA.size == ARLEN + 1;
                            ARLEN != 'hf;   
                          }
/*
   constraint READY_values{  
                        //    BREADY == 1;
                        //    RREADY == 1;
                          }			  
*/
   constraint four_kb_boundary{
                               AWADDR[12:0] <= (4096 - ((AWLEN+1)*(2**AWSIZE))); 
                               ARADDR[12:0] <= (4096 - ((ARLEN+1)*(2**ARSIZE))); 
                              }		  
       
   constraint write_addr_allignment{
                               if(AWSIZE == 'd1)   AWADDR[0]   == 'd0; 
                               if(AWSIZE == 'd2)   AWADDR[1:0] == 'd0; 
                               if(AWSIZE == 'd3)   AWADDR[2:0] == 'd0; 
                               if(AWSIZE == 'd4)   AWADDR[3:0] == 'd0; 
                               if(AWSIZE == 'd5)   AWADDR[4:0] == 'd0; 
                               if(AWSIZE == 'd6)   AWADDR[5:0] == 'd0; 
                               if(AWSIZE == 'd7)   AWADDR[6:0] == 'd0; 
                             }
       
   constraint read_addr_allignment{
                               if(ARSIZE == 'd1)   ARADDR[0]   == 'd0; 
                               if(ARSIZE == 'd2)   ARADDR[1:0] == 'd0; 
                               if(ARSIZE == 'd3)   ARADDR[2:0] == 'd0; 
                               if(ARSIZE == 'd4)   ARADDR[3:0] == 'd0; 
                               if(ARSIZE == 'd5)   ARADDR[4:0] == 'd0; 
                               if(ARSIZE == 'd6)   ARADDR[5:0] == 'd0; 
                               if(ARSIZE == 'd7)   ARADDR[6:0] == 'd0; 
                             } 


   extern function new(string name="axi_txn");

endclass
 
  function axi_txn::new(string name="axi_txn");
      super.new(name);
  endfunction

   






   

