class axi_env extends uvm_env;
   `uvm_component_utils(axi_env)
  
   axi_agent agent_h; 

   function new(string name="axi_env",uvm_component parent);
            super.new(name,parent);
   endfunction 
  
   function void build_phase(uvm_phase phase);
         super.build_phase(phase);
         agent_h = axi_agent::type_id::create("agent_h",this);
   endfunction 

endclass     
