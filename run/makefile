clean: 
	rm -fr work *.wlf *.log

qp1:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top  -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*;coverage save -onexit <TESTSET_CODE_COVER> .vcdb; run -all;quit" -coverage -voptargs="+cover=bcfst" -l sim.log


qp2:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top +UVM_TESTNAME=wr_only_test -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*; run -all;quit" -l sim.log


qp3:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top +UVM_TESTNAME=rd_only_test -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*; run -all;quit" -l sim.log

qp4:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top +UVM_TESTNAME=wr_rd_test -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*; run -all;quit" -l sim.log

qp5:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top +UVM_TESTNAME=rand_wr_rd_test -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*; run -all;quit" -l sim.log

qp6:clean
	Vlib work
	Vlog +acc -sv ../dut/apb_design.v +indir+../dut ../tb/testbench.sv +indir+../tb   -l comp.log
	Vsim -i tbench_top +UVM_TESTNAME=with_wait_states_test -do  "add wave -position insertpoint sim:/tbench_top/i_intf/*; run -all;quit" -l sim.log
