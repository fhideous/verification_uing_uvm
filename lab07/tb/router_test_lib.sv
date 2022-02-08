
class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  router_tb rot_tb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_int::set( this, "*", "recording_detail", 1);
    rot_tb = router_tb::type_id::create("root_tb", this);
    `uvm_info(get_type_name(), "Build Phase of the test is being exexuted", UVM_HIGH)
  endfunction : build_phase

//The drain time allows packets to pass through the router before simulation ends
 // Why i need it?... idk 
  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 200ns);
  endtask : run_phase

  //This will help debug configuration errors by reporting any unmatched settings.
  function void check_phase(uvm_phase phase);
    check_config_usage();
  endfunction : check_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();    
  endfunction : end_of_elaboration_phase

endclass : base_test 

///==================
// End of Based class 
///===================



//--------------
// Execute yapp_uvc with yapp_012_seq and some other new uvcs with their sequence 
//---------------

class simple_test extends base_test;

  `uvm_component_utils(simple_test)

  function new(string name, uvm_component parent);  
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    // set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
    yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());
    uvm_config_wrapper::set(this, "root_tb.yapp.tx_agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_012_seq::get_type());
    uvm_config_wrapper::set(this, "root_tb.clk_reset.agent.sequencer.run_phase",
                            "default_sequence",
                            clk10_rst5_seq::get_type());
    // execute uvc for all three channels
    uvm_config_wrapper::set(this, "root_tb.ch?.rx_agent.sequencer.run_phase",
                            "default_sequence",
                            channel_rx_resp_seq::get_type());  
    super.build_phase(phase);  
  endfunction : build_phase

endclass : simple_test
