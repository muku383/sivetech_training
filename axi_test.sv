class axi_test extends uvm_test;
    `uvm_component_utils(axi_test) 
     
     function new(string name="axi_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     axi_env env_h;

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
         env_h = axi_env::type_id::create("env_h",this);
     endfunction

     function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        print();
     endfunction

endclass 

class reset_test extends axi_test;
   `uvm_component_utils(reset_test)

     function new(string name="reset_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          reset_seq seq_h = reset_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass

class fixed_test extends axi_test;
   `uvm_component_utils(fixed_test)

     function new(string name="fixed_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          fixed_seq seq_h = fixed_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass

class incr_test extends axi_test;
   `uvm_component_utils(incr_test)

     function new(string name="incr_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          incr_seq seq_h = incr_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass


class wrap_test extends axi_test;
   `uvm_component_utils(wrap_test)

     function new(string name="wrap_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          wrap_seq seq_h = wrap_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass


class multi_read_write_test extends axi_test;
   `uvm_component_utils(multi_read_write_test)

     function new(string name="multi_read_write_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          multi_read_write_seq seq_h = multi_read_write_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass

class multi_read_write_incr_test extends axi_test;
   `uvm_component_utils(multi_read_write_incr_test)

     function new(string name="multi_read_write_incr_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          multi_read_write_incr_seq seq_h = multi_read_write_incr_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass

class multi_read_write_wrap_test extends axi_test;
   `uvm_component_utils(multi_read_write_wrap_test)

     function new(string name="multi_read_write_wrap_test",uvm_component parent);
              super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
     endfunction
     
     task run_phase(uvm_phase phase);
          multi_read_write_wrap_seq seq_h = multi_read_write_wrap_seq::type_id::create("seq_h");     // need to change
          phase.raise_objection(this);
          seq_h.start(env_h.agent_h.seqr_h);                     // need to change
          phase.drop_objection(this);
    endtask
endclass


