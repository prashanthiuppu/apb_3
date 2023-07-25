class apb_config extends uvm_object;

//	`uvm_object_utils(apb_config)
//	 apb_config cfg;
    



  // Configuration variables
  int no_of_slave_agents =1;
  int no_of_master_agents =1;
  bit insert_wait_cycles;
  int no_of_wait_cycles;
  bit error_injection_enable;
  bit timeout_enable;
  bit [2:0] write_read_flag;
  int num;
    
  `uvm_object_utils_begin(apb_config)
  `uvm_field_int(no_of_slave_agents,UVM_ALL_ON)
  `uvm_field_int(no_of_master_agents,UVM_ALL_ON)
  `uvm_field_int(insert_wait_cycles,UVM_ALL_ON)
  `uvm_field_int(error_injection_enable,UVM_ALL_ON)
  `uvm_field_int(timeout_enable,UVM_ALL_ON)
  `uvm_field_int(num,UVM_ALL_ON)
  `uvm_field_int(write_read_flag,UVM_ALL_ON)
  `uvm_object_utils_end



  // Constructor
  function new(string name = "apb_config");
    super.new(name);
  endfunction


 endclass

