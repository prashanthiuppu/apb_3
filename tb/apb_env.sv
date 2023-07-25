class apb_env extends uvm_env;
  
  `uvm_component_utils(apb_env)
  
     apb_config cfg;
  
  //agent and scoreboard instance
 apb_agent apb_agnt[];
 
 // apb_agent apb_agnt;
  apb_scoreboard apb_scb;
  
  //constructor method
   function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase buliding the components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     apb_scb=apb_scoreboard::type_id::create("apb_scb",this);

   if (!uvm_config_db#(apb_config)::get(this , "" , "cfg" ,cfg )) begin
        `uvm_fatal ("NO_CONFIG",{"config_db must be set for:",get_full_name(),"cfg"});
   end
cfg.num=2;
   apb_agnt=new[cfg.no_of_master_agents];
    foreach(apb_agnt[i])

    //apb_agnt[i]=apb_agent::type_id::create($sformat("apb_agnt[%0d]",i),this);
       apb_agnt[i]=apb_agent::type_id::create("apb_agnt",this);
          cfg.print();

  endfunction:build_phase
  
  //connect phase connecting monitor and scoreboard
 function void connect_phase(uvm_phase phase);
	 foreach(apb_agnt[i])
    apb_agnt[i].monitor.item_collected_port.connect(apb_scb.item_collected_export);
  endfunction:connect_phase
endclass
    
