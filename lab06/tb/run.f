 -uvmhome $UVMHOME


// include directory for sv files
-incdir ../sv

// default timescale
-timescale 1ns/1ns

// options
//+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
+UVM_TESTNAME=all_outputs

+UVM_VERBOSITY=UVM_FULL
//+UVM_VERBOSITY=UVM_LOW

+SVSEED=random

../sv/yapp_pkg.sv 
../sv/yapp_if.sv
clkgen.sv
hw_top.sv
tb_top.sv     

// RTL
../router_rtl/yapp_router.sv