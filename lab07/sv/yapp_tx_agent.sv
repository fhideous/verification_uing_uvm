
class yapp_tx_agent extends uvm_agent;

  yapp_tx_driver      driver;
  yapp_tx_sequencer   sequencer;
  yapp_tx_monitor     monitor;

  `uvm_component_utils_begin(yapp_tx_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON);
  `uvm_component_utils_end

  extern function      new                        (string name, uvm_component parent);
  extern function void build_phase                ( uvm_phase phase );
  extern function void connect_phase              ( uvm_phase phase );
  extern function void start_of_simulation_phase  ( uvm_phase phase );

endclass : yapp_tx_agent

//=================================================================================
//Implementaitions
//=================================================================================

function yapp_tx_agent::new (string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

function void yapp_tx_agent::build_phase( uvm_phase phase );
  super.build_phase(phase);
  monitor = yapp_tx_monitor::type_id::create("monitor", this);
  if ( is_active == UVM_ACTIVE ) begin
    sequencer = yapp_tx_sequencer::type_id::create("sequencer",  this);
    driver    = yapp_tx_driver::type_id::create("driver",     this);
  end
endfunction : build_phase

function void yapp_tx_agent::connect_phase( uvm_phase phase );
  if ( is_active == UVM_ACTIVE )
    driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction : connect_phase

function void yapp_tx_agent::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
endfunction : start_of_simulation_phase