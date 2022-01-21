
class router_tb extends uvm_env;

  `uvm_component_utils(router_tb)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

// maybe should use "MSG" or something instead "get_type name()"
    `uvm_info(get_type_name(), "Build Phase of the testbench is being exexuted", UVM_HIGH)

  endfunction : build_phase
endclass : router_tb