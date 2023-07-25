class apb_agent extends uvm_agent;
  
 `uvm_component_utils(apb_agent)
   apb_config cfg;

  //declaring agent components
  apb_sequencer sequencer1;
  apb_driver    driver   ;
  apb_monitor   monitor  ;


  //constructor method
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()==UVM_ACTIVE)begin    
    sequencer1=apb_sequencer::type_id::create("sequencer1",this);
    driver=apb_driver::type_id::create("driver",this);
    end
    monitor=apb_monitor::type_id::create("monitor",this);
      if (!uvm_config_db#(apb_config)::get(this , "" , "cfg" ,cfg )) begin
        `uvm_fatal ("FOR MASTER AGENT" , "PLEASE SET THE CONFIG OBJECT")
     end
 	 
  endfunction:build_phase
  
  //connect phase
  function void connect_phase(uvm_phase phase);
	  if(get_is_active()==UVM_ACTIVE)begin
      driver.seq_item_port.connect(sequencer1.seq_item_export);
      end
  endfunction:connect_phase
endclass

