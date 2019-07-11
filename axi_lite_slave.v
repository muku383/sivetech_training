`timescale 1ns/1ps

module axi_lite_slave #
  (
   parameter integer C_S_AXI_BASE_ADDR            = 32'h0000_0000,
   parameter integer C_S_AXI_HIGH_ADDR            = 32'h0000_FFFF,
   parameter integer C_S_AXI_ADDR_WIDTH            = 32,
   parameter integer C_S_AXI_DATA_WIDTH            = 32
   )
  (
   // System Signals
   input wire ACLK,
   input wire ARESETN,

   // Slave Interface Write Address Ports
   input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
   input wire	[3:0]			S_AXI_AWID,
   input  wire [3-1:0]                  S_AXI_AWPROT,
   input  wire                          S_AXI_AWVALID,
   input wire  [3:0]			S_AXI_AWLEN,
   input wire  [2:0]			S_AXI_AWSIZE,
   input wire  [2:0]			S_AXI_ARSIZE,
   input wire  [1:0]			S_AXI_AWBURST,
   input wire  [1:0]			S_AXI_ARBURST,
   output wire                          S_AXI_AWREADY,

   // Slave Interface Write Data Ports
   input wire  [3:0]			  S_AXI_WID,
   input  wire [C_S_AXI_DATA_WIDTH-1:0]   S_AXI_WDATA,
   input  wire [C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
   input  wire                            S_AXI_WVALID,
   input  wire                            S_AXI_WLAST,
   output wire                            S_AXI_WREADY,

   // Slave Interface Write Response Ports
   output wire	[3:0]		       S_AXI_BID,
   output wire [2-1:0]                 S_AXI_BRESP,
   output wire                         S_AXI_BVALID,
   input  wire                         S_AXI_BREADY,

   // Slave Interface Read Address Ports
   input wire	[3:0]			S_AXI_ARID,
   input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
   input  wire [3-1:0]                  S_AXI_ARPROT,
   input  wire                          S_AXI_ARVALID,
	input wire [3:0]		S_AXI_ARLEN,
   output wire                          S_AXI_ARREADY,

   // Slave Interface Read Data Ports
   output wire  [3:0]                  S_AXI_RID,
   output reg [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
   output wire [2-1:0]                 S_AXI_RRESP,
   output wire                         S_AXI_RVALID,
   input  wire                         S_AXI_RREADY,
output wire 			       S_AXI_RLAST
   
  );
    reg        [31:0 ]                              temp_addr;
    reg        [35:0 ]                              temp_addr_with_id;
    reg        [35:0 ]                              temp_addr_2;
    int i,j,k;
    
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg [0:255] ;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg_addr = C_S_AXI_BASE_ADDR;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg0;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg1;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg2;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg3;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg4;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg5;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg6;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg7;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg8;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg0_addr = C_S_AXI_BASE_ADDR;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg1_addr = C_S_AXI_BASE_ADDR + 4;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg2_addr = C_S_AXI_BASE_ADDR + 8;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg3_addr = C_S_AXI_BASE_ADDR + 12;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg4_addr = C_S_AXI_BASE_ADDR + 16;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg5_addr = C_S_AXI_BASE_ADDR + 20;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg6_addr = C_S_AXI_BASE_ADDR + 24;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg7_addr = C_S_AXI_BASE_ADDR + 28;
    reg        [C_S_AXI_DATA_WIDTH-1 : 0]           slv_reg8_addr = C_S_AXI_BASE_ADDR + 32;

	reg [31:0] read_address ;
	reg	   arready ;
	reg [1:0]   rresp;
	reg	    rvalid;
	reg [31:0] rdata;
reg [3:0] count;
wire [3:0] count2;
reg [31:0] write_address = S_AXI_AWADDR ;
	reg	   awready ;
	reg [1:0]   bresp;
	reg	    wvalid;
	reg [31:0] wdata =  S_AXI_WDATA;
	reg  wready;
	reg  bvalid;
	reg rlast;
        reg[3:0]arlen;
	reg  arvalid;
	assign arlen= S_AXI_ARLEN;
	assign S_AXI_AWREADY = awready ;
	assign S_AXI_ARREADY = arready ;
	assign S_AXI_RRESP = rresp;
	assign S_AXI_RVALID = rvalid;
//	assign S_AXI_RDATA = $random();
	assign S_AXI_RDATA = rdata;
	assign S_AXI_WREADY = wready;
	assign S_AXI_BVALID = bvalid;
//	assign S_AXI_ARVALID = arvalid;
assign S_AXI_RLAST = rlast;
	assign S_AXI_BRESP = bresp;
//	assign S_AXI_WVALID = wvalid;
assign S_AXI_BID =S_AXI_AWID;
assign S_AXI_RID=S_AXI_ARID;
///assign S_AXI_ARLEN=S_AXI_AWLEN;
//assign S_AXI_RDATA=S_AXI_WDATA;


	//Write Address channel
	always @ (posedge ACLK)
	begin

      //  if (ARESETN == 1'b0)
	  if (ARESETN != 1'b1)
	  begin
		awready <= 1'b0;
		rresp<=2'b11;
	//	bresp<=2'b11;
		rvalid<=1'b0;
		wready<=1'b0;
	//	bvalid<=1'b0;

		//write_address 	<= write_address;
	  end
	  else if(S_AXI_AWVALID==1'b1)
	  begin
	  if(( C_S_AXI_BASE_ADDR <  S_AXI_AWADDR < C_S_AXI_HIGH_ADDR ))
		begin
		awready <= 1'b1;
		write_address 	= S_AXI_AWADDR;
		end
		else
		begin
		awready <= 1'b1;
		write_address 	= write_address;
		end

	  end
	end
// increment logic implemented by bhaskar;

        bit[35:0] a[$];
        bit[31:0] align_addr;
        bit[31:0] align_addr_1;
        bit[31:0] upper_wrap_boundary;
        bit[31:0] upper_wrap_boundary_1;
        bit[31:0] wrap_boundary;
        bit[31:0] wrap_boundary_1;
        bit [9:0] n;   
        bit [9:0] o;   

        always @(posedge ACLK)
         begin
              // if (ARESETN == 1'b0)
               if (ARESETN != 1'b1)
                  begin
                    i=0;
                    n=0;
                    o=0;
                  end
	       else if( S_AXI_AWVALID ==  1 && S_AXI_AWBURST== 'b00)
                  begin
                     temp_addr = S_AXI_AWADDR;
                     temp_addr_with_id = {S_AXI_AWID, temp_addr};
                     a.push_back(temp_addr_with_id);
                  end
	       else if( S_AXI_AWVALID ==  1 && S_AXI_AWBURST== 'b01)
 	            begin
                      for (i = 1; i <= (S_AXI_AWLEN+1); i = i+1 )
                         begin
		         //  temp_addr =  S_AXI_AWADDR + (i-1) * (S_AXI_AWLEN+1);
                           temp_addr = align_addr + (i-1)*(2**S_AXI_AWSIZE);
                           temp_addr_with_id = {S_AXI_AWID, temp_addr};
                           a.push_back(temp_addr_with_id);
                           $display($time, " temp_addr = %d address in queue = %d" ,temp_addr_with_id, a[i-1]);
                           @(posedge ACLK);
                         end
                    end
	       else if( S_AXI_AWVALID ==  1 && S_AXI_AWBURST== 'b10)
                    begin : abc1
                      align_addr=(S_AXI_AWADDR/ (2**S_AXI_AWSIZE))* (2**S_AXI_AWSIZE);
                      wrap_boundary =(S_AXI_AWADDR/((S_AXI_AWLEN+1)*(2**S_AXI_AWSIZE))) *((S_AXI_AWLEN+1)*(2**S_AXI_AWSIZE));
                      upper_wrap_boundary =wrap_boundary+((S_AXI_AWLEN+1)*(2**S_AXI_AWSIZE));
 $display($time, " *-***-*****--------*********--------******-----****---***- s_axi_awburst==> %h , wrap_boundary = %h, upper_wrap_boundary= %h, align_addr= %h, S_AXI_AWSIZE = %h, S_AXI_AWLEN = %h" , S_AXI_AWBURST , wrap_boundary , upper_wrap_boundary, align_addr , S_AXI_AWSIZE , S_AXI_AWLEN);
                   begin  : abc
                     for(i=1 ; i < (S_AXI_AWLEN +2) ; i = i+1)
                       begin 
                           @(posedge ACLK); 
                           temp_addr = align_addr + (i-1)*(2**S_AXI_AWSIZE);
                           if(temp_addr != upper_wrap_boundary)
                             begin  
                              temp_addr = temp_addr; 
                              temp_addr_with_id = {S_AXI_AWID, temp_addr};
                              a.push_back(temp_addr_with_id);
                             end : if_end
                           else
                             begin
                              for(n = 1; n < (S_AXI_AWLEN+1-i); n= n+1);
                                 begin
                                       begin
                                          if(n==1) 
                                             begin  temp_addr = wrap_boundary;
                                                    temp_addr_with_id = {S_AXI_AWID, temp_addr};
                                                    a.push_back(temp_addr_with_id); 
                                                    i = i+1;
                                                    @(posedge ACLK);
                                             end
                                          else begin
                                                    @(posedge ACLK);
                                                    temp_addr = temp_addr + ( n*(2**S_AXI_AWSIZE));
                                                    temp_addr_with_id = {S_AXI_AWID, temp_addr};
                                                    a.push_back(temp_addr_with_id);
                                                    i = i+1;
                                                end 
                                       end 
                                       break;
                                 end : for_loop_end 
                             end : else_end    
                       end : for_loop_end
                    end : abc
                    end : abc1
          end : always_end
                        

	//Write Data Channel
	always @ (posedge ACLK)
	begin
               if (ARESETN != 1'b1)
		     begin
				wready <= 1'b0;
				bresp <= 2'b00; //OKAY
				bvalid <= 1'b0;
         	     end : if_end
	  	else
	  	     begin
				if( C_S_AXI_BASE_ADDR <  S_AXI_AWADDR < C_S_AXI_HIGH_ADDR && S_AXI_WVALID)
			               begin
                                            for (k = 1; k <= (S_AXI_AWLEN+1); k = k+1 )
                                              begin
                                                temp_addr_2 = a.pop_front;
                                                 $display($time,"value of -**+**$$$--- temp_addr_2 = %h ",temp_addr_2);
                                                slv_reg[temp_addr_2]   <= S_AXI_WDATA;    // write data
					           

                                                     wready <= 1'b1;
                                                        $display($time,"ENTEREDDDD before elseeeee");
                                                 //  if(S_AXI_WLAST==1)
                                                 //  if((S_AXI_AWLEN+1)==k)
                                                    @(negedge S_AXI_WLAST);
                                                    //   begin
                                                         //   while(S_AXI_BREADY != 1'b1)
                                                         //   @(posedge S_AXI_BREADY);
                                                        $display($time,"ENTEREDDDD if WLAST==1");
                                                            @(posedge ACLK);
					            	bresp <= 2'b00; //OKAY
					            	bvalid <= 1'b1;
                                                            @(posedge ACLK);
					            	bvalid <= 1'b0;
                                                    //  end
                                                   @(posedge ACLK);
					      end : for_loop_end
                                       end : if_end
				else
					begin
						wready <= 1'b1;
                                           $display($time,"ENTEREDDDD in elseeeeeeee");
                                              // if(S_AXI_WLAST==1)
                                             //   if( S_AXI_BREADY);
                                                 @(negedge S_AXI_WLAST);
                                                //  begin
                                                      //  while(S_AXI_BREADY != 1'b1)
                                                      //  @(posedge S_AXI_BREADY);
                                                        $display($time,"EN1TEREDDDD if WLAST==1");
                                                        @(posedge ACLK);
					        	bresp <= 2'b00; //OKAY
					        	bvalid <= 1'b1;
                                                     //   while(S_AXI_BREADY != 1'b1)
                                                        @(posedge ACLK);
					        	bvalid <= 1'b0;
                                                 // end
					end : else_end

	  		end : else_end
	  	//else
	  	//	begin
	  		//	wready <= 1'b1;
	 		//	 bresp <= 2'b00; //OKAY
	 		//	 bvalid <= 1'b1;
	  	//	end
	end : always_end


//Read Address Channel
always @ (posedge ACLK)
	begin
 //	if (ARESETN == 1'b0)
         if (ARESETN != 1'b1)
          arready<=1'b0;
else
   begin
	if(S_AXI_ARVALID== 1'b1)
			begin
				arready  	<= 1'b1 ;
				read_address 	<= S_AXI_ARADDR;
			end
		else
			begin
				arready  	<= 1'b0 ;
				read_address <= read_address ;
			end

	end
end


// increment logic implemented by bhaskar;

        //int queue a[$]; 
        int l,m,zzzz;  
        bit[35:0] b[$];  
        bit [31:0] temp_addr_3; 
        bit [35:0] temp_addr_4; 
        bit [35:0] temp_addr_with_id_2; 

        always @(posedge ACLK)
         begin
               if (ARESETN == 1'b0)
                 begin
                 end
	       else if( S_AXI_ARVALID ==  1 && S_AXI_ARBURST == 'b00)
                 begin
                     temp_addr_3 = S_AXI_ARADDR;
                     temp_addr_with_id_2 = {S_AXI_ARID, temp_addr_3};
                     b.push_back(temp_addr_with_id_2);
                 end
	       else if( S_AXI_ARVALID ==  1 && S_AXI_ARBURST == 'b01)
 	           begin
                      for (l = 1; l <= (S_AXI_ARLEN+1); l = l+1 )
                       begin
		          // temp_addr_3 =  S_AXI_ARADDR + (l-1) * (S_AXI_ARLEN+1);
                           temp_addr_3 = align_addr_1 + (l-1)*(2**S_AXI_ARSIZE);
                           temp_addr_with_id_2 = {S_AXI_ARID, temp_addr_3};
                           b.push_back(temp_addr_with_id_2);
                           $display($time, " temp_addr = %d address in queue = %d" ,temp_addr_with_id_2, b[l-1]);
                          @(posedge ACLK);
                       end
                   end
               else if( S_AXI_ARVALID ==  1 && S_AXI_ARBURST== 'b10)
                   begin
                      align_addr_1=(S_AXI_ARADDR/ (2**S_AXI_ARSIZE))* (2**S_AXI_ARSIZE);
                      wrap_boundary_1 =(S_AXI_ARADDR/((S_AXI_ARLEN+1)*(2**S_AXI_ARSIZE))) *((S_AXI_ARLEN+1)*(2**S_AXI_ARSIZE));
                      upper_wrap_boundary_1 =wrap_boundary_1+((S_AXI_ARLEN+1)*(2**S_AXI_ARSIZE));
 $display($time, " *-***-*****--------*********--------******-----****---***- s_axi_awburst==> %h , wrap_boundary = %h, upper_wrap_boundary= %h, align_addr= %h, S_AXI_AWSIZE = %h, S_AXI_AWLEN = %h" , S_AXI_AWBURST , wrap_boundary , upper_wrap_boundary, align_addr , S_AXI_AWSIZE , S_AXI_AWLEN);
                   begin  
                     for(l=1 ; l < (S_AXI_ARLEN +2) ; l = l+1)
                       begin 
                           @(posedge ACLK); 
                           temp_addr_3 = align_addr_1 + (l-1)*(2**S_AXI_ARSIZE);
                           if(temp_addr_3 != upper_wrap_boundary_1)
                             begin  
                              temp_addr_3 = temp_addr_3; 
                              temp_addr_with_id_2 = {S_AXI_ARID, temp_addr_3};
                              b.push_back(temp_addr_with_id_2);
                             end
                           else
                             begin
                              for(o = 1; o < (S_AXI_ARLEN+1-l); o= o+1);
                                 begin
                                 begin
                                    if(o==1) begin  temp_addr_3 = wrap_boundary_1;
                              temp_addr_with_id_2 = {S_AXI_ARID, temp_addr_3};
                              b.push_back(temp_addr_with_id_2); 
                              l = l+1;
                                   @(posedge ACLK);
                                     end
                                    else begin
                                   @(posedge ACLK);
                                   temp_addr_3 = temp_addr_3 + ( o*(2**S_AXI_ARSIZE));
                                   temp_addr_with_id_2 = {S_AXI_ARID, temp_addr_3};
                                   b.push_back(temp_addr_with_id_2);
                                   l = l+1;
                                   end 
                                 end 
                                  break;
                                 end 
                             end    
                             end    
                             end    
                             end    

         end

assign count2 = (ARESETN != 'b1) ? 'd0 : S_AXI_ARLEN+1 ;

//Read Data Channel
always @ (posedge ACLK)
  begin
     count <= count2;
     // if(ARESETN==1'b0)
     if(ARESETN != 1'b1)
        begin	rvalid<=1'b0;
        	rlast<=1'b0;
     	     //   count<=4'b0000;
        end	  
     else
       begin	if((S_AXI_RREADY == 1'b1) && (count != 0))
                   begin
                             //    zzzz = 2;
				if(( C_S_AXI_BASE_ADDR > read_address > C_S_AXI_HIGH_ADDR ))
					begin
						rvalid <= 1'b00;
						rresp <= 2'b00; //OKAY
					end
				else
				    begin
                                             rlast<=1'b0;  
                                         for (j = 0; j <= S_AXI_ARLEN; j = j+1 )
                                           begin
                                             temp_addr_4 = b.pop_front;
                                             $display($time,"value of -**+**$$$--- temp_addr_4 = %h ",temp_addr_4);
						rvalid <= 1'b1;
						rresp <= 2'b00; //OKAY
                                             rdata <= $random();    // read data
                                             $display("*+*/*/*/*/++*/*/*/*/*+//**///*/**+++++++*///**"); 
				              if(j==S_AXI_ARLEN)
			 	               begin 
                                            
                                                rlast<=1'b1;  
                                                @(posedge ACLK) ; 
                                                rvalid<=1'b0;
                                                rlast<=1'b0;  
                                         //       zzzz = 5;
                                                end
                                                 $display("value of j=%d , count= %d",j,count);
                                                  count--;   
                                             @(posedge ACLK) ; 
	  		                 end : for_loop_end
	  		            end :else_end
                   end : if_end
       end     
  end
 
endmodule
