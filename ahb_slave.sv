
module ahb_slave(
    input hclk,
	 input hresetn,
    input [31:0] hwdata,
    input [31:0] haddr,
	 input [2:0] hburst,
	 input [1:0] htrans,
	 input hwrite,
	 output reg [31:0] din,
	 input [31:0] dout,
	 output wire r_en_ff,w_en_ff,
	 input hsel,
	 input fifo_empty,fifo_full,
	// input fifo_almost_empty,fifo_almost_full,
    output reg hreadyout,
    //input slave_busy1,
    output reg [31:0] hrdata
    );

parameter ADDR = 2'b00;
parameter READ = 2'b01;
parameter WRITE = 2'b10;
parameter WAIT = 2'b11;

reg [3:0] count=1;

reg [1:0] current_state,next_state;
reg [31:0] mem [0:'hff];
reg [31:0] saddr;
reg slave_busy1=0;
reg [3:0] num_of_beats;

wire last;
	
assign hreadyout = (current_state==READ || current_state==WRITE ) ? !slave_busy1 : 'b0;
assign last = (count == num_of_beats -1 ) ? 'b1:'b0; 
assign r_en_ff = (current_state==READ)  ? 1 : 0;
assign w_en_ff = (current_state==WRITE) ? 1 : 0;
//assign hrdata = (current_state==READ) ? dout : hrdata;
// assign slave_busy1 = (((current_state==READ) && fifo_empty) || ((current_state==WRITE) && fifo_full)) ? 1 : 0;

//  always @ (posedge hclk or negedge hresetn)
  always @ (posedge hclk)
	begin
		if(!hresetn)
			next_state <= ADDR;
		else	
			current_state <= next_state;
	end	 
		
  always @ (*)
	begin
		case(current_state)
			ADDR	:	begin
						if((slave_busy1 == 0) && (hwrite == 0) && ((htrans==2'd1) || (htrans==2'd2)))
							next_state = READ;
						else if((slave_busy1 == 0) && (hwrite == 1) && ((htrans==2'd1) || (htrans==2'd2)))
							next_state = WRITE;	
						else if((slave_busy1 == 1) && ((htrans==2'd1) || (htrans==2'd2)))
							next_state = WAIT;	
						else if(htrans == 2'b00)
							next_state = ADDR;
						end	
							
	
			READ	:	if(htrans == 2'b00)
							 next_state = ADDR;	
						else if(((slave_busy1 == 1) && (!last)) || (htrans ==2'd0))
							next_state = WAIT;  
						else if((slave_busy1 == 0) && (!last)  && (hwrite == 0))
							next_state = READ;
						else if(last && hwrite == 1 && htrans == 2'd2)
							next_state = WRITE;						

			WRITE	:	if(htrans == 2'b00)
						   	next_state = ADDR;   
						else if(((slave_busy1 == 1) && (!last)) || (htrans ==2'd0))
							next_state = WAIT;
						else if((slave_busy1 == 0) && (!last)  && (hwrite == 1))
							next_state = WRITE;	
						else if(last && hwrite == 0 && htrans == 2'd2)
							next_state = READ;						
							
			WAIT	:	
					   if(htrans == 2'b00)
							next_state = WAIT;	
						else if((slave_busy1 == 0)  && (hwrite == 0) && (htrans !=2'd0))
							next_state = READ;
						else if((slave_busy1 == 0)  && (hwrite == 1) && (htrans !=2'd0))
							next_state = WRITE;	
		endcase	
	
	end
  
   always @ (posedge hclk)
	begin
			if(current_state == ADDR || current_state == READ || current_state == WRITE )
				saddr <= haddr	;
	end  
	
 //  always @ (posedge hclk or posedge hresetn)
   always @ (posedge hclk )
	begin
		if(!hresetn)
			begin	
				count <=0;
			//	hrdata <=0;
			end	
		else	
			begin	
					case (current_state)
						ADDR :	begin
										
											count <=0;
									end
						READ : begin
						//	hrdata <= dout;
							hrdata <= mem[saddr];		// how to handle address in FIFO??
							if (htrans==2'd2)
								count <= 0;
							else	
								count <= count+1;
						 end	
						 
						WRITE : begin
							din <= hwdata;
						mem[saddr] <= hwdata;	// how to handle address in FIFO??
							if (htrans==2'd2)
								count <= 0;
							else	
								count <= count+1;
								 end
							
					endcase
			end		
	end

	
   always @ (posedge hclk)
	begin
		if(current_state==ADDR)
			case(hburst)
				3'd2 : num_of_beats <= 4;
				3'd3 : num_of_beats <= 4;
				3'd4 : num_of_beats <= 8;
				3'd5 : num_of_beats <= 8;
				3'd6 : num_of_beats <= 16;
				3'd7 : num_of_beats <= 16;
				default : num_of_beats <= 1;
			endcase	
			 
	end  		
	
		
endmodule
