class apb_sequence extends uvm_sequence#(apb_seq_item);
  
  `uvm_object_utils(apb_sequence)
  
  //constructor method
  function new(string name="apb_sequence");
    super.new(name);
  endfunction
  
  //creating the sequence item and send to driver

 virtual task body();
  repeat(5)begin
  req  =  apb_seq_item::type_id::create("req");
   start_item(req);
    req.randomize();
    finish_item(req);
       end
  endtask
 endclass


 /* virtual task body();
  begin

  `uvm_do_with(req, {req.paddr == 8'h1a; req.pwdata == 8'h11; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h22; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h19; req.pwdata == 8'h33; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h44; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h17; req.pwdata == 8'h55; req.pwrite == 1'b1; })

  `uvm_do_with(req, {req.paddr == 8'h1a;  req.pwrite == 1'b0; })
  `uvm_do_with(req, {req.paddr == 8'h1c;  req.pwrite == 1'b0; })
  `uvm_do_with(req, {req.paddr == 8'h19;  req.pwrite == 1'b0; })
  `uvm_do_with(req, {req.paddr == 8'h1c;  req.pwrite == 1'b0; })
  `uvm_do_with(req, {req.paddr == 8'h17;  req.pwrite == 1'b0; })

 
  end



  endtask
  endclass*/

//----------------------------------------------------------------------WRITE_ONLY_SEQUENCE---------------------------------------------------------------------------//

class apb_wr_seq extends apb_sequence;
  
  `uvm_object_utils(apb_wr_seq)
  
  //constructor method
  function new(string name="apb_wr_seq");
    super.new(name);
  endfunction

  virtual task body();
  
	  `uvm_do_with(req, {req.paddr == 8'h00; req.pwdata == 32'h00000000; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'hff; req.pwdata == 32'hffffffff; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'h00; req.pwdata == 32'h00000000; req.pwrite == 1'b1; })
 	
  endtask
endclass


//--------------------------------------------------------------READ_ONLY_SEQUENCE------------------------------------------------------------------------------------//


class apb_rd_seq extends apb_sequence;
  
  `uvm_object_utils(apb_rd_seq)
  
  //constructor method
  function new(string name="apb_rd_seq");
    super.new(name);
  endfunction

   virtual task body();
  repeat(100)begin
  req  =  apb_seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize()with{pwrite==1'b0;});
    finish_item(req);
       end



   
  endtask
endclass



//---------------------------------------------------------------------WRITE_FOLLOWED_BY_READ_SEQUENCE----------------------------------------------------------------//
class apb_wr_rd_seq extends apb_sequence;
  
  `uvm_object_utils(apb_wr_rd_seq)
  
  
  //constructor method
  function new(string name="apb_wr_rd_seq");
    super.new(name);
  endfunction

  virtual task body();
  begin

  `uvm_do_with(req, {req.paddr == 8'h00; req.pwdata == 32'h00000000; req.pwrite == 1'b1; })
  // `uvm_do_with(req, {req.paddr == 8'h1a;  req.pwrite == 1'b0; })


  `uvm_do_with(req, {req.paddr == 8'hff; req.pwdata == 32'hffffffff; req.pwrite == 1'b1; })
 // `uvm_do_with(req, {req.paddr == 8'h1c;  req.pwrite == 1'b0; })

  `uvm_do_with(req, {req.paddr == 8'h00; req.pwdata == 32'h00000000; req.pwrite == 1'b1; })
 // `uvm_do_with(req, {req.paddr == 8'h19;  req.pwrite == 1'b0; })

     end      
  endtask
endclass

//----------------------------------------------------------------------RAND_WRITE_READ_SEQUENCE----------------------------------------------------------------------//
class apb_rand_wr_rd_seq extends apb_sequence;
  
  `uvm_object_utils(apb_rand_wr_rd_seq)
  
  //constructor method
  function new(string name="apb_rand_wr_rd_seq");
    super.new(name);
  endfunction

   virtual task body();
  repeat(2000)begin
  req  =  apb_seq_item::type_id::create("req");
   start_item(req);
    req.randomize();
    finish_item(req);
       
     // `uvm_do(req)
      end
  endtask
 endclass


//----------------------------------------------------------------WRITE_WITH_WAIT_STATES_SEQUENCE---------------------------------------------------------------------//


class apb_wait_seq extends apb_sequence;
  
  `uvm_object_utils(apb_wait_seq)
  
  //constructor method
  function new(string name="apb_wait_seq");
    super.new(name);
  endfunction

   virtual task body();
 /*  begin
  
	  `uvm_do_with(req, {req.paddr == 8'h1a; req.pwdata == 8'h11; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h22; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'h19; req.pwdata == 8'h33; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h44; req.pwrite == 1'b1; })
          `uvm_do_with(req, {req.paddr == 8'h17; req.pwdata == 8'h55; req.pwrite == 1'b1; })
   end*/




   repeat(50)begin
  req  =  apb_seq_item::type_id::create("req");
   start_item(req);
  assert(req.randomize() with {req.pwrite==1'b1;});
    finish_item(req);
       
     // `uvm_do(req)
      end

   endtask
 endclass


//-------------------------------------------------------------WRITE_READ_WITH_WAIT_STATES----------------------------------------------------------------------------//


class apb_wr_rd_wait_seq extends apb_sequence;
  
  `uvm_object_utils(apb_wr_rd_wait_seq)
  
  //constructor method
  function new(string name="apb_wr_rd_wait_seq");
    super.new(name);
  endfunction

  virtual task body();
  begin

  `uvm_do_with(req, {req.paddr == 8'h1a; req.pwdata == 8'h11; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h1a;  req.pwrite == 1'b0; })

  `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h22; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h1c;  req.pwrite == 1'b0; })

  `uvm_do_with(req, {req.paddr == 8'h19; req.pwdata == 8'h33; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h19;  req.pwrite == 1'b0; })

  `uvm_do_with(req, {req.paddr == 8'h1c; req.pwdata == 8'h44; req.pwrite == 1'b1; })
  `uvm_do_with(req, {req.paddr == 8'h1c;  req.pwrite == 1'b0; })
 
   `uvm_do_with(req, {req.paddr == 8'h17; req.pwdata == 8'h55; req.pwrite == 1'b1; })
   `uvm_do_with(req, {req.paddr == 8'h17;  req.pwrite == 1'b0; })
   end

  endtask
endclass

