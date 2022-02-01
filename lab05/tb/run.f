 -uvmhome $UVMHOME


// include directory for sv files
-incdir ../sv

//+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
+UVM_TESTNAME=set_config_test

+UVM_VERBOSITY=UVM_HIGH
//+UVM_VERBOSITY=UVM_LOW
+SVSEED=random
// compile YAPP package and top level module
../sv/yapp_pkg.sv 
top.sv     