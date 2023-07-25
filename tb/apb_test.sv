
class apb_test extends uvm_test;
  
  `uvm_component_utils(apb_test)
  
  apb_env env;
  apb_sequence apb_seq;
  apb_config cfg;
   virtual intf vif;
  int i,j;

  // 000-write_only,001-read_only,010-write_followed_by_read,011-rand_wr_rd,100-write_with_wait_states,101-write_read_with_wait_states
 
  bit [2:0] write_read_flag=3'b011;

  // wait state on=1,off=0
  bit insert_wait_cycles = 0;

  //no of wait cycles
   int no_of_wait_cycles = 1;

   function flag();
	   cfg=new();
	   cfg.write_read_flag    =  write_read_flag;
	   cfg.insert_wait_cycles =  insert_wait_cycles;
	   cfg.no_of_wait_cycles  =  no_of_wait_cycles ;
   endfunction


  function new(string name="apb_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  //build phase creating environment and sequence
  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    env=apb_env::type_id::create("env",this);
    cfg=apb_config::type_id::create("cfg",this);
    flag();
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))begin
      `uvm_fatal("NO_VIF",{" virtual interface must be set for:",get_full_name(),".vif"});
    end
 uvm_config_db#(apb_config)::set(this,"*","cfg",cfg);
       cfg.print();
   endfunction


  virtual function void end_of_elaboration_phase (uvm_phase phase);
       uvm_top.print_topology();
  endfunction :end_of_elaboration_phase


  //run phase starting the test
  task run_phase(uvm_phase phase);
	   `uvm_info(get_full_name(),"start test",UVM_LOW);	 

    apb_seq=apb_sequence::type_id::create("apb_seq");
    phase.raise_objection(this);
    apb_seq.start(env.apb_agnt[0].sequencer1);
    #50;
    phase.drop_objection(this);
    `uvm_info(get_full_name(),"end test",UVM_LOW);	 

  endtask:run_phase
endclass

//---------------------------------------------------------------WRITE_ONLY_TESTCASE----------------------------------------------------------------------------------//

class wr_only_test extends apb_test;

	`uvm_component_utils(wr_only_test)
	apb_wr_seq wr_seq;

	function new(string name="wr_only_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		wr_seq=apb_wr_seq::type_id::create("wr_seq");

		wr_seq.start(env.apb_agnt[0].sequencer1);
                #100;
		phase.drop_objection(this);
	endtask
endclass


//------------------------------------------------------READ_ONLY_TESTCASE--------------------------------------------------------------------------------------------//

class rd_only_test extends apb_test;

	`uvm_component_utils(rd_only_test)
	apb_rd_seq rd_seq;

	function new(string name="rd_only_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		rd_seq=apb_rd_seq::type_id::create("rd_seq");
		for(int i=0,j=0;i<255;i++,j++)
                $root.tbench_top.dut.mem[i]=j;
               	rd_seq.start(env.apb_agnt[0].sequencer1);
                #100;
		phase.drop_objection(this);
	endtask
endclass


//---------------------------------------------------WRITE_FOLLOWED_BY_READ_TESTCASE----------------------------------------------------------------------------------------------//

class wr_rd_test extends apb_test;

	`uvm_component_utils(wr_rd_test)
	apb_wr_rd_seq wr_rd_seq;

	function new(string name="wr_rd_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	       	wr_rd_seq=apb_wr_rd_seq::type_id::create("wr_rd_seq");

		wr_rd_seq.start(env.apb_agnt[0].sequencer1);
                #25;
		phase.drop_objection(this);
	endtask
endclass



//--------------------------------------------------------------RANDOM_WRITE_READ_TESTCASE----------------------------------------------------------------------------//


class rand_wr_rd_test extends apb_test;

	`uvm_component_utils(rand_wr_rd_test)
	apb_rand_wr_rd_seq  rand_wr_rd_seq;

	function new(string name="rand_wr_rd_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	       	rand_wr_rd_seq=apb_rand_wr_rd_seq::type_id::create("rand_wr_rd_seq");

		rand_wr_rd_seq.start(env.apb_agnt[0].sequencer1);
                #100;
		phase.drop_objection(this);
	endtask
endclass



//------------------------------------------------------WRITE_WITH_WAIT_STATES_TESTCASE-------------------------------------------------------------------------------------//



class with_wait_states_test extends apb_test;

	`uvm_component_utils(with_wait_states_test)
	apb_wait_seq wait_seq;

	function new(string name="with_wait_states_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wait_seq=apb_wait_seq::type_id::create("wait_seq");
	endfunction
        
	task w_state();
              if(cfg.insert_wait_cycles)
		  begin
		 
			  repeat(cfg.no_of_wait_cycles)
		  begin
                            @(posedge vif.pclk);
			 force $root.tbench_top.dut.pready=0;
 		   end
		    @(posedge vif.pclk);
		     release tbench_top.dut.pready;
	     end
	endtask





	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		fork
		begin
	        #50;
		w_state();
		#50;
		w_state();
		#50;
		w_state();
		#50;
		w_state();
         	end
		begin
         	wait_seq.start(env.apb_agnt[0].sequencer1);
		end 
		join
          

         
                #100;
		phase.drop_objection(this);
	endtask
endclass



//---------------------------------------------------WRITE_READ_WITH_WAIT_STATES----------------------------------------------------------------------------------------//

class wrrd_with_wait_states_test extends apb_test;

	`uvm_component_utils(wrrd_with_wait_states_test)
	apb_wr_rd_wait_seq wrrd_wait_seq;

	function new(string name="wrrd_with_wait_states_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	       	wrrd_wait_seq=apb_wr_rd_wait_seq::type_id::create("wrrd_wait_seq");

		wrrd_wait_seq.start(env.apb_agnt[0].sequencer1);
                #100;
		phase.drop_objection(this);
	endtask
endclass









    
