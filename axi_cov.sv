 class coverage;
    axi_txn axi_txn_h;
    
    covergroup cg();
       RESET     : coverpoint axi_txn_h.ARESETn;
       
       AW_ADDR   : coverpoint axi_txn_h.AWADDR;
       AW_ID     : coverpoint axi_txn_h.AWID;
       AW_LEN    : coverpoint axi_txn_h.AWLEN;
       AW_SIZE   : coverpoint axi_txn_h.AWSIZE;
       AW_BURST  : coverpoint axi_txn_h.AWBURST;
       AW_VALID  : coverpoint axi_txn_h.AWVALID;
       AW_READY  : coverpoint axi_txn_h.AWREADY;
       
       AR_ADDR   : coverpoint axi_txn_h.ARADDR;
       AR_ID     : coverpoint axi_txn_h.ARID;
       AR_LEN    : coverpoint axi_txn_h.ARLEN;
       AR_SIZE   : coverpoint axi_txn_h.ARSIZE;
       AR_BURST  : coverpoint axi_txn_h.ARBURST;
       AR_VALID  : coverpoint axi_txn_h.ARVALID;
       AR_READY  : coverpoint axi_txn_h.ARREADY;
       
       W_ID      : coverpoint axi_txn_h.WID;
       W_DATA    : coverpoint axi_txn_h.WDATA;
       W_STRB    : coverpoint axi_txn_h.WSTRB;
       W_LAST    : coverpoint axi_txn_h.WLAST;
       W_VALID   : coverpoint axi_txn_h.WVALID;
       W_READY   : coverpoint axi_txn_h.WREADY;
       
       R_ID      : coverpoint axi_txn_h.RID;
       R_DATA    : coverpoint axi_txn_h.RDATA;
       R_RESP    : coverpoint axi_txn_h.RRESP;
       R_LAST    : coverpoint axi_txn_h.RLAST;
       R_VALID   : coverpoint axi_txn_h.RVALID;
       R_READY   : coverpoint axi_txn_h.RREADY;
       
       B_RESP    : coverpoint axi_txn_h.BRESP;
       B_ID      : coverpoint axi_txn_h.BID;
       B_VALID   : coverpoint axi_txn_h.BVALID;
       B_READY   : coverpoint axi_txn_h.BREADY;

    endgroup
    
    cg cg_h;

    function new();
          cg_h = new();
    endfunction

    task cov_sample(axi_txn axi_txn_h);
        this.axi_txn_h = axi_txn_h;
        cg_h.sample();
    endtask
endclass
