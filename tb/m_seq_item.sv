class apb_seq_item extends uvm_sequence_item;
  
  //data and control field
  rand bit [7:0]  paddr;
  rand bit [31:0] pwdata;
       bit [31:0] prdata;
  rand bit pwrite;
   bit penable;
   bit psel;
       bit pready;
  
  
  `uvm_object_utils_begin(apb_seq_item)
  `uvm_field_int(paddr,UVM_ALL_ON)
  `uvm_field_int(pwdata,UVM_ALL_ON)
  `uvm_field_int(prdata,UVM_ALL_ON)
  `uvm_field_int(pwrite,UVM_ALL_ON)
  `uvm_field_int(psel,UVM_ALL_ON)
  `uvm_field_int(penable,UVM_ALL_ON)
  `uvm_field_int(pready,UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  
  
  //constructor
  function new(string name="apb_seq_item");
    super.new(name);
  endfunction
  
  
 // constraint c1{paddr  inside {[0:100]};};
  //constraint c2{pwdata inside {[0:255]};};
  
endclass
