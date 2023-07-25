class apb_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(apb_scoreboard)

	//associative array to store write data
	bit[31:0] ref_data[*];
	uvm_analysis_imp #(apb_seq_item,apb_scoreboard)item_collected_export;

	function new(string name="apb_scoreboard",uvm_component parent);
		super.new(name,parent);
	endfunction


	virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	item_collected_export=new("item_collected_export",this);
        endfunction

	//implementing the write function

        virtual function void write(apb_seq_item req_collected);
 
  begin

	 if(req_collected.pwrite==1)
	 
                                    begin

	                            ref_data[req_collected.paddr]=req_collected.pwdata;  // data comes from monitor 
                                    end
   
				    else  begin
	        	if (ref_data.exists(req_collected.paddr)) begin	    
	                if ((ref_data[req_collected.paddr]==req_collected.prdata)) begin
		            `uvm_info(get_full_name(),$sformatf(" \t paddr=%0h, \t pwdata=%0h,\t prdata=%0h", req_collected.paddr,req_collected.pwdata,req_collected.prdata ),UVM_LOW);
                           `uvm_info(get_full_name(),"read_operation_matched_with_write_operation", UVM_LOW);
                    
	                end
                	else begin

                          `uvm_info(get_full_name(),"read_operation_not_matched_with_write_operation", UVM_LOW);
                       
		              end
                         end
		 end

       // else   `uvm_info(get_full_name(),"data_not_exist_in_the_addr", UVM_LOW);
	    
  end   
 
     `uvm_info(get_full_name(),$sformatf(" \t paddr=%0h, \t pwdata=%0h,\t prdata=%0h", req_collected.paddr,req_collected.pwdata,req_collected.prdata ),UVM_LOW);    
	    
endfunction : write


endclass	







































































































/*class apb_scoreboard extends uvm_scoreboard;
	apb_seq_item tr;
  
  // uvm utility - registred this component by using factory mechanisam
  `uvm_component_utils(apb_scoreboard)
  
    uvm_analysis_imp#(apb_seq_item, apb_scoreboard) item_collected_export;
  
    bit [31:0] sc_mem [int];
  
   // constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
    tr =new();
    item_collected_export = new("mon_export", this);
  endfunction
  
   // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("%t I am in scoreboard class build phase",$time);
    
  endfunction
  
  function void write(apb_seq_item tr);
	  `uvm_info(get_full_name(),$sformatf(" \t paddr=%0h, \t pwdata=%0h,\t prdata=%0h", tr.paddr,tr.pwdata,tr.prdata ),UVM_LOW)
           tr.print();	
  	sc_mem[tr.paddr]=tr.pwdata;

  endfunction
    
     virtual task run_phase(uvm_phase phase);
   forever
    begin
	`uvm_info("APB scoreboard",$sformatf("------ ::DATA Recieved in scoreboard :: ------"),UVM_LOW)
    // if(tr.pwrite == 1)
     //begin
	 if(sc_mem[tr.paddr] == tr.prdata)
		 `uvm_info("APB scoreboard",$sformatf("------ ::DATA Match :: ------"),UVM_LOW)

	 // else   if(sc_mem[tr.paddr] == tr2.prdata)
	  //   `uvm_info("APB scoreboard",$sformatf("------ ::READ DATA Match :: ------"),UVM_LOW)
      else
     	`uvm_info("APB scoreboard",$sformatf("------ ::DATA MisMatch :: ------"),UVM_LOW)

    #5;
    end

  endtask 
  
endclass*/


















































