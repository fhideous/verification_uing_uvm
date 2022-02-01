 -uvmhome $UVMHOME


// include directory for sv files
-incdir ../sv

//+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
+UVM_TESTNAME=incr_payload_test

+UVM_VERBOSITY=UVM_FULL
//+UVM_VERBOSITY=UVM_LOW

+SVSEED=random
// compile YAPP package and top level module
../sv/yapp_pkg.sv 
top.sv     