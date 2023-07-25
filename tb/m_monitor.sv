class apb_monitor extends uvm_monitor;
  
  //declaring virtual interface
  virtual intf vif;
   apb_config cfg;

  
  //registering with uvm factory
  `uvm_component_utils(apb_monitor)
  
  //analysis port declaration
  uvm_analysis_port#(apb_seq_item)item_collected_port;
  apb_seq_item req_collected;
  
  //new constructor
  function new(string name,uvm_component parent);
    super.new(name,parent);
    req_collected=new();
    item_collected_port=new("item_collected_port",this);
  endfunction
  
  // build phase,connecting interface to virtual interface using get method
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if (!uvm_config_db#(apb_config)::get(this , "" , "cfg" ,cfg )) begin
        `uvm_fatal ("NO_CONFIG",{"config_db must be set for:",get_full_name(),"cfg"});
   end

    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal("NOVIF",{" virtual interface must be set for:",get_full_name(),".vif"});
  endfunction:build_phase
  
    
    
 virtual task run_phase(uvm_phase phase);
     $display("%t I am in monitor class run phase",$time);
           forever begin
		@(posedge vif.pclk);
                req_collected.pwrite = vif.pwrite;
		req_collected.paddr = vif.paddr;
		req_collected.psel = vif.psel;
		req_collected.penable = vif.penable;
		if(req_collected.pwrite ==1 && req_collected.psel ==1 && req_collected.penable ==1)
			req_collected.pwdata = vif.pwdata;
		else if(req_collected.pwrite ==0 && req_collected.psel ==1 && req_collected.penable ==1)
			req_collected.prdata = vif.prdata;	
       			`uvm_info(get_full_name(),"In the monitor component",UVM_LOW);
			req_collected.print();
			`uvm_info(get_full_name(),$sformatf(" \t paddr=%0h, \t pwdata=%0h,\t prdata=%0h", req_collected.paddr,vif.pwdata,vif.prdata ),UVM_LOW)
       //Write to analysis port     
         item_collected_port.write(req_collected);
	//tr1.print(); 
	cfg.print();
 end
     #20;
   endtask

endclass
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /* forever begin
      @(posedge vif.pclk);
      if(vif.preset)begin
	      req_collected.print();
	      drive_txn;
	      item_collected_port.write(req_collected);
      end
      end
      endtask

      task drive_txn();
      `uvm_info(get_full_name(),"start monitor",UVM_LOW);
          req_collected.paddr=vif.paddr;
          req_collected.pwrite=vif.pwrite;
	  req_collected.psel=vif.psel;
          req_collected.penable=vif.penable;
	  @(posedge vif.pclk);
	  if(vif.pwrite==1)begin

          req_collected.pwdata=vif.pwdata;
  end
  else begin
	   req_collected.prdata=vif.prdata;
 end
	   `uvm_info(get_full_name(),"end monitor",UVM_LOW);
	   `uvm_info(get_type_name(),$sformatf("\t PADDR=%0h, \t PWDATA=%0h, \t  PRDATA=%0h",vif.paddr,vif.pwdata,vif.prdata),UVM_LOW);
  endtask
endclass*/
