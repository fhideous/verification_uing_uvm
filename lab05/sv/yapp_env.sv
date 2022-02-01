class yapp_env extends uvm_env;
  
  yapp_tx_agent tx_agent;

  `uvm_component_utils(yapp_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
    
  function void build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"You are in the env:", get_full_name()}, UVM_LOW)
    super.build_phase(phase);
    tx_agent = yapp_tx_agent::type_id::create("tx_agent", this);
  endfunction : build_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase  

endclass : yapp_env