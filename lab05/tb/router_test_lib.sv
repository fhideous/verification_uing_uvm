
class base_test extends uvm_test;

`uvm_component_utils(base_test)

router_tb rot_tb;

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_wrapper::set(this, "root_tb.yapp.tx_agent.sequencer.run_phase",
                              "default_sequence",
                              yapp_5_packets::get_type());
  uvm_config_int::set( this, "*", "recording_detail", 1);
  rot_tb = router_tb::type_id::create("root_tb", this);
  `uvm_info(get_type_name(), "Build Phase of the test is being exexuted", UVM_HIGH)
endfunction : build_phase

//This will help debug configuration errors by reporting any unmatched settings.
function void check_phase(uvm_phase phase);
  check_config_usage();
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();    
endfunction : end_of_elaboration_phase

endclass : base_test 



class short_packet_test extends base_test;

`uvm_component_utils(short_packet_test)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
  yapp_packet::type_id::set_type_override(short_yapp_packet::get_type()); 
  super.build_phase(phase);
  uvm_config_wrapper::set(this, "root_tb.yapp.tx_agent.sequencer.run_phase",
                              "default_sequence",
                              yapp_5_packets::get_type());
endfunction : build_phase

endclass : short_packet_test



class set_config_test extends base_test;

`uvm_component_utils(set_config_test)

function new(string name, uvm_component parent);  
  super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
  uvm_config_int::set(this, "root_tb.yapp.tx_agent", "is_active", UVM_PASSIVE);
  uvm_config_wrapper::set(this, "root_tb.yapp.tx_agent.sequencer.run_phase",
                              "default_sequence",
                              yapp_5_packets::get_type());
  super.build_phase(phase);
endfunction : build_phase


endclass //set_config_test extends base_test