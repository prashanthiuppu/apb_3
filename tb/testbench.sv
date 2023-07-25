`include "interface.sv"

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "config.sv"
`include "m_seq_item.sv"
`include "ma_sequence.sv"
`include "ma_sequencer.sv"
`include "m_driver.sv"
`include "m_monitor.sv"
`include "m_agent.sv"
`include "apb_scoreboard.sv"
`include "apb_env.sv"
`include "apb_test.sv"





  
module tbench_top();  
  bit pclk;
  bit preset;
  always  begin
	  #10 pclk=!pclk;
  end
  
  //reset generation
  initial begin
    preset=0;
    #5 preset=1;
   // #2000 $finish;
  end
  
  intf i_intf(pclk,preset);
  
  apb_slave dut(
    .pclk(i_intf.pclk),
    .preset(i_intf.preset),
    .psel(i_intf.psel),
    .penable(i_intf.penable),
    .pwrite(i_intf.pwrite),
    .pwdata(i_intf.pwdata),
    .paddr(i_intf.paddr),
    .prdata(i_intf.prdata),
    .pready(i_intf.pready)
  );
  
  //passing interface handle to lower hierarchy using set method
  initial begin
    uvm_config_db#(virtual intf)::set(null,"*","vif",i_intf);
 //   $root.tbench_top.dut.pready=0;
  end
  
  initial begin
   // run_test("apb_test");       //qp1
   // run_test("wr_only_test");   //qp2
  // run_test("rd_only_test");   //qp3 
 //  run_test("wr_rd_test");     //qp4
run_test("rand_wr_rd_test"); //qp5
  // run_test("with_wait_states_test"); //qp6
  //  run_test("wrrd_with_wait_states_test");
  end
  
endmodule
