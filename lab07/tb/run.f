 -uvmhome $UVMHOME


// include directory for sv files
-incdir ../sv
-incdir ../yapp/sv
-incdir ../channel/sv
-incdir ../hbus/sv
-incdir ../clock_and_reset/sv


// default timescale
-timescale 1ns/1ns

// options
+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
//+UVM_TESTNAME=all_outputs

+UVM_VERBOSITY=UVM_FULL
//+UVM_VERBOSITY=UVM_LOW

+SVSEED=random

// UVC package filename
../sv/yapp_pkg.sv
../channel/sv/channel_pkg.sv 
../hbus/sv/hbus_pkg.sv 
../clock_and_reset/sv/clock_and_reset_pkg.sv 

// UVC interface filename.
../sv/yapp_if.sv 
../channel/sv/channel_if.sv 
../hbus/sv/hbus_if.sv 
../clock_and_reset/sv/clock_and_reset_if.sv 


clkgen.sv
hw_top.sv
tb_top.sv     

// RTL
../router_rtl/yapp_router.sv