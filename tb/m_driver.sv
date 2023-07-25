class apb_driver extends uvm_driver#(apb_seq_item);
  
  //virtual interface
  virtual intf vif;
   apb_config cfg;

  
 //register with uvm factory
  `uvm_component_utils(apb_driver)
  
  //constructor method
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if (!uvm_config_db#(apb_config)::get(this , "" , "cfg" ,cfg )) begin
        `uvm_fatal ("NO_CONFIG",{"config_db must be set for:",get_full_name(),"cfg"});
   end

    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))begin
      `uvm_fatal("NO_VIF",{" virtual interface must be set for:",get_full_name(),".vif"});
    end
  endfunction:build_phase
  
 
  //run phase
  virtual task run_phase(uvm_phase phase);
   forever begin
    `uvm_info(get_full_name(),"start driver",UVM_LOW);	 
      seq_item_port.get_next_item(req);
      drive();
      cfg.print();
       
     `uvm_info(get_full_name(),"end driver",UVM_LOW);	
      
      seq_item_port.item_done();
   end
  endtask


 
  virtual task drive();
  case(cfg.write_read_flag)
	 
 //WRITE_ONLY
	  3'b000:begin
		 @(posedge vif.pclk);
		  vif.psel <= 0;
	          vif.penable <= 0;
                  if(req.pwrite==1) begin
                  vif.psel<=1;
                  vif.penable<=0;
                  vif.pwrite<=req.pwrite;
                  vif.paddr<=req.paddr;
                  vif.pwdata<=req.pwdata;
                  @(posedge vif.pclk);
                  vif.penable<=1;
	         end
	         end
 
 //READ_ONLY
	  3'b001:begin
		 @(posedge vif.pclk);
		 vif.psel<=0;
                 vif.penable<=0;
		// @(posedge vif.pclk);
		 if(req.pwrite==0) begin

		 vif.psel<=1; 
                 vif.pwrite<=0;
                 vif.paddr<=req.paddr;
                 @(posedge vif.pclk);
                 vif.penable<=1;
                 req.prdata<=vif.prdata;
                 end
	 end
          
 
 //WRITE_FOLLOWED_BY_READ
            3'b010:begin
	   // begin
		  @(posedge vif.pclk);
	          vif.psel <= 0;
	          vif.penable <= 0;
                  @(posedge vif.pclk);
                 // if(req.pwrite==1) begin
                  vif.psel<=1;
                 // vif.penable<=0;
                  vif.pwrite<=1;
                  vif.paddr<=req.paddr;
                  vif.pwdata<=req.pwdata;
                  @(posedge vif.pclk);
                  vif.penable<=1;
		    @(posedge vif.pclk);
		   vif.psel <= 0;
	          vif.penable <= 0;
                 // end
                //  else
		 // begin
		  @(posedge vif.pclk);
		     vif.psel<=1;
                //  vif.penable<=0; 
                  vif.pwrite<=0;
                  vif.paddr<=req.paddr;
		  req.prdata<=vif.prdata;
                  @(posedge vif.pclk);
                  vif.penable<=1; 
                 // end
                  end
     





//RANDOM_WRITE_AND_READ
            3'b011:begin
		  @(posedge vif.pclk);
	          vif.psel <= 0;
	          vif.penable <= 0;
                  @(posedge vif.pclk);
                 // if(req.pwrite==1) begin
                  vif.psel<=1;
                 // vif.penable<=0;
                  vif.pwrite<=1;
                  vif.paddr<=req.paddr;
                  vif.pwdata<=req.pwdata;
                  @(posedge vif.pclk);
                  vif.penable<=1;
		  //  @(posedge vif.pclk);
		  //   vif.psel <= 0;
	          //vif.penable <= 0;
                  //end
                 // else
		 // begin
		  @(posedge vif.pclk);
		     vif.psel<=1;
                  vif.penable<=0; 
                  vif.pwrite<=0;
                  vif.paddr<=req.paddr;
                  @(posedge vif.pclk);
                  vif.penable<=1; 
                  req.prdata<=vif.prdata;
                //  end
                  end




 //WRITE_WITH_WAIT_STATES
		 
          3'b100: begin
		   @(posedge vif.pclk);
		   wait(vif.pready==1);
	   begin
		  vif.psel <= 0;
	          vif.penable <= 0;
		   @(posedge vif.pclk);
		 if(req.pwrite==1)begin
	          vif.psel<=1;
		 vif.penable <= 0;
		   vif.pwrite<=1;
		  req.pready<=vif.pready;
                  vif.paddr<=req.paddr;
                  vif.pwdata<=req.pwdata;
                  @(posedge vif.pclk);
                  vif.penable<=1;
		 		 /* if(cfg.insert_wait_cycles)
		  begin
		 
			  repeat(cfg.no_of_wait_cycles)
		  begin
                           // @(posedge vif.pclk);
			   force tbench_top.dut.pready=0;
		   end
		    @(posedge vif.pclk);
		     release tbench_top.dut.pready;
		      @(posedge vif.pclk);*/

	    
	     end
	     
    end
     end

//WRITE_READ_WITH_WAIT_STATES
             
          3'b101:begin
		  @(posedge vif.pclk);
		 // vif.psel <= 0;
	          vif.penable <= 0;

		 if(req.pwrite==1)begin
	          vif.psel<=1;
		  vif.penable <= 0;
		   vif.pwrite<=req.pwrite;
                  vif.paddr<=req.paddr;
                  vif.pwdata<=req.pwdata;
                  @(posedge vif.pclk);
                  vif.penable<=1;
		  if(cfg.insert_wait_cycles)
		  begin
		 
			  repeat(cfg.no_of_wait_cycles)
		  begin
                           // @(posedge vif.pclk);
			   force tbench_top.dut.pready=0;
		   end
	   
		    @(posedge vif.pclk);
		     release tbench_top.dut.pready;
		      @(posedge vif.pclk);
	      end
     end
	     
            
     else  begin 
	         vif.psel<=1; 
                 vif.pwrite<=0;
		  vif.penable<=0;
                 vif.paddr<=req.paddr;
                 @(posedge vif.pclk);
                 vif.penable<=1;
                // req.prdata<=vif.prdata;
		 if(cfg.insert_wait_cycles)
		  begin
		 
			  repeat(cfg.no_of_wait_cycles)
		  begin
                           // @(posedge vif.pclk);
			   force tbench_top.dut.pready=0;
		   end
	   
		    @(posedge vif.pclk);
		     release tbench_top.dut.pready;
	     end
		     req.prdata<=vif.prdata;
		      @(posedge vif.pclk);

      	      
      end
          
end
   endcase
      `uvm_info(get_type_name(),$sformatf("\t PADDR=%0h, \t PWDATA=%0h,\t PRDATA=%0h",req.paddr,req.pwdata,vif.prdata),UVM_LOW);
 endtask
 endclass













  
  
/*  virtual task drive();
 begin
	  @(posedge vif.pclk);
	 // vif.psel <= 0;
	  vif.penable <= 0;


if(req.pwrite==1) begin
      
      vif.psel<=1;
      vif.penable<=0;
      vif.pwrite<=req.pwrite;
      
      vif.paddr<=req.paddr;
      vif.pwdata<=req.pwdata;
      
      @(posedge vif.pclk);
      vif.penable<=1;
 end
    
  else begin
      vif.psel<=1;
      vif.penable<=0; 
      vif.pwrite<=0;
      vif.paddr<=req.paddr;
       req.prdata<=vif.prdata;


      @(posedge vif.pclk);

       vif.penable<=1;
                       
        end
  end
   `uvm_info(get_type_name(),$sformatf("\t PADDR=%0h, \t PWDATA=%0h,\t PRDATA=%0h",req.paddr,req.pwdata,vif.prdata),UVM_LOW);
 endtask

endclass*/
  
         
   





