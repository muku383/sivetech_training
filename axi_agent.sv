class axi_agent extends uvm_agent;
    `uvm_component_utils(axi_agent)

     axi_drv driver_h;
     axi_mon    mon_h;
     axi_seqr   seqr_h;  
  
     function new(string name="axi_agent",uvm_component parent);
             super.new(name,parent);
     endfunction
   
     function void build_phase(uvm_phase phase);
             super.build_phase(phase);
             driver_h = axi_drv::type_id::create("driver_h",this);
             mon_h    = axi_mon::type_id::create("mon_h",this);
             seqr_h   = axi_seqr::type_id::create("seqr_h",this);
     endfunction

     function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
          driver_h.seq_item_port.connect(seqr_h.seq_item_export);
     endfunction

endclass
