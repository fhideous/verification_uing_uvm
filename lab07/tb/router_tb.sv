
class router_tb extends uvm_env;

  `uvm_component_utils(router_tb)

  yapp_env yapp;

  channel_env channel0;
  channel_env channel1;
  channel_env channel2;

  hbus_env            hbus;
  clock_and_reset_env clk_reset;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    yapp = yapp_env::type_id::create("yapp", this);
    `uvm_info(get_type_name(), "Build Phase of the testbench is being exexuted", UVM_HIGH)

    channel0 = channel_env::type_id::create("ch0", this);
    channel1 = channel_env::type_id::create("ch1", this);
    channel2 = channel_env::type_id::create("ch2", this);
    uvm_config_int::set(this, "ch0", "channel_id", 0);
    uvm_config_int::set(this, "ch1", "channel_id", 1);
    uvm_config_int::set(this, "ch2", "channel_id", 2);

    hbus = hbus_env::type_id::create("hbus", this);
    uvm_config_int::set(this, "hbus", "num_masters", 1);
    uvm_config_int::set(this, "hbus", "num_slaves", 0);

    clk_reset = clock_and_reset_env::type_id::create("clk_reset", this);

  endfunction : build_phase

endclass : router_tb