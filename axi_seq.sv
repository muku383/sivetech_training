class axi_seq extends uvm_sequence#(axi_txn);
   `uvm_object_utils(axi_seq)
  // `uvm_declare_p_sequencer(axi_seqr)   
 
    function new(string name="axi_seq");
          super.new(name);
    endfunction
endclass

class reset_seq extends axi_seq;
   `uvm_object_utils(reset_seq)
   axi_txn pkt; 
   extern function new(string name="reset_seq");
   extern task body();

endclass

           function reset_seq::new(string name="reset_seq");
                super.new(name);
           endfunction

           task reset_seq::body();
              pkt = axi_txn::type_id::create("pkt");
              start_item(pkt);
              assert(pkt.randomize() with { ARESETn == 0 ;} );
              finish_item(pkt);  
           endtask

class fixed_seq extends axi_seq;
   `uvm_object_utils(fixed_seq)
   axi_txn pkt; 
   extern function new(string name="fixed_seq");
   extern task body();

endclass

           function fixed_seq::new(string name="fixed_seq");
                super.new(name);
           endfunction

           task fixed_seq::body();
              pkt = axi_txn::type_id::create("pkt");
              start_item(pkt);
              assert(pkt.randomize() with {(AWBURST == 'd0) && (ARBURST == 'd0);} );
              finish_item(pkt);  
           endtask


class incr_seq extends axi_seq;
   `uvm_object_utils(incr_seq)
   axi_txn pkt; 
   extern function new(string name="incr_seq");
   extern task body();

endclass

          function incr_seq::new(string name="incr_seq");
               super.new(name);
          endfunction

          task incr_seq::body();
             pkt = axi_txn::type_id::create("pkt");
             start_item(pkt);
             assert(pkt.randomize() with {(ARESETn == 1) && (AWBURST == 'd1) && (ARBURST == 'd1);} );
             finish_item(pkt);  
          endtask

class wrap_seq extends axi_seq;
   `uvm_object_utils(wrap_seq)
   axi_txn pkt; 
   extern function new(string name="wrap_seq");
   extern task body();

endclass

          function wrap_seq::new(string name="wrap_seq");
               super.new(name);
          endfunction

          task wrap_seq::body();
             pkt = axi_txn::type_id::create("pkt");
             start_item(pkt);
             assert(pkt.randomize() with {(ARESETn == 1) && (AWBURST == 'd2) && (ARBURST == 'd2); } );
             finish_item(pkt);  
          endtask

class multi_read_write_seq extends axi_seq;
   `uvm_object_utils(multi_read_write_seq)
   axi_txn pkt; 
   int unsigned n_times = 10;
   extern function new(string name="multi_read_write_seq");
   extern task body();

endclass

         function multi_read_write_seq::new(string name="multi_read_write_seq");
              super.new(name);
         endfunction
        
         task multi_read_write_seq::body();
            pkt = axi_txn::type_id::create("pkt");
            repeat(n_times) begin
               start_item(pkt);
               assert(pkt.randomize() );            // need to modify
               finish_item(pkt);  
            end
         endtask

class multi_read_write_incr_seq extends axi_seq;
   `uvm_object_utils(multi_read_write_incr_seq)
   axi_txn pkt; 
   int unsigned n_times = 10;
   extern function new(string name="multi_read_write_incr_seq");
   extern task body();

endclass

         function multi_read_write_incr_seq::new(string name="multi_read_write_incr_seq");
              super.new(name);
         endfunction

         task multi_read_write_incr_seq::body();
            pkt = axi_txn::type_id::create("pkt");
            repeat(n_times) begin
               start_item(pkt);
               assert(pkt.randomize() with {(AWBURST == 'd1) && (ARBURST == 'd1);} );            // need to modify
               finish_item(pkt);  
            end
         endtask

class multi_read_write_wrap_seq extends axi_seq;
   `uvm_object_utils(multi_read_write_wrap_seq)
   axi_txn pkt; 
   int unsigned n_times = 10;
   extern function new(string name="multi_read_write_wrap_seq");
   extern task body();

endclass

         function multi_read_write_wrap_seq::new(string name="multi_read_write_wrap_seq");
              super.new(name);
         endfunction

         task multi_read_write_wrap_seq::body();
            pkt = axi_txn::type_id::create("pkt");
            repeat(n_times) begin
               start_item(pkt);
               assert(pkt.randomize()  with {(AWBURST == 'd2) && (ARBURST == 'd2);} );            // need to modify
               finish_item(pkt);  
            end
         endtask



