interface ahb_if(input logic clk, resetn);   

//	logic hresetn;
	logic [31:0] haddr;
	logic [31:0] hwdata;
	logic [31:0] hrdata;
	logic hwrite;
	logic [2:0] hburst;
	logic [2:0] hsize;
	logic [1:0] htrans;
	logic [1:0] hresp;
	logic [3:0] hprot;
	logic hsel;
	logic hreadyout;
	logic [15:0]hsplitx;
	logic [3:0]hmaster;
	logic hmastlock;
 
	clocking  master @( posedge clk);
        output haddr,hwdata,hwrite,hburst,hsize,htrans,hprot,hsel;
        input hreadyout,hresp,hrdata;
        endclocking

	clocking  monitor @( posedge clk);
        input haddr,hwdata,hwrite,hburst,hsize,htrans,hprot,hsel,hreadyout,hresp,hrdata;
        endclocking
	
      //modport AHB_DRIVER (clocking clk_block ,input clk,resetn); 
    //  modport AHB_MONITOR (clocking clk_block_m, input clk, resetn); 
	 
endinterface: ahb_if
