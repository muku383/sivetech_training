class axi_seqr extends uvm_sequencer#(axi_txn);
   `uvm_component_utils(axi_seqr)   

   extern function new(string name="axi_seqr",uvm_component parent);
      
endclass

   function axi_seqr::new(string name="axi_seqr",uvm_component parent);
         super.new(name,parent);
   endfunction


  
