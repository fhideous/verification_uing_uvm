
class router_tb extends uvm_env;

  `uvm_component_utils(router_tb)

  yapp_env yapp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    yapp = new("yapp", this);
    `uvm_info(get_type_name(), "Build Phase of the testbench is being exexuted", UVM_HIGH)

  endfunction : build_phase

endclass : router_tb