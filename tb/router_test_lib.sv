
class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)

  router_tb rot_tb;


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rot_tb = new("rot_tb", this);

    `uvm_info(get_type_name(), "Build Phase of the test is being exexuted", UVM_HIGH)
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();    
  endfunction : end_of_elaboration_phase

endclass : base_test 