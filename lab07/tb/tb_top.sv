
module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import yapp_pkg::*;
  
  import hbus_pkg::*;
  import channel_pkg::*;
  import channel_pkg::*;

  `include "router_tb.sv"
  `include "router_test_lib.sv"

  initial begin 
    yapp_vif_config::set            (null,  "*.root_tb.yapp.tx_agent.*",  "vif", hw_top.in0         );
    hbus_vif_config::set            (null,  "*.root_tb.hbus.*" ,          "vif", hw_top.hif         );
    channel_vif_config::set         (null,  "*.root_tb.chan0.*",          "vif", hw_top.ch0         );
    channel_vif_config::set         (null,  "*.root_tb.chan1.*",          "vif", hw_top.ch1         );
    channel_vif_config::set         (null,  "*.root_tb.chan2.*",          "vif", hw_top.ch2         );
    clock_and_reset_vif_config::set (null,  "*.root_tb.clock_and_reset*", "vif", hw_top.clk_rst_if  );
    
    run_test();
  end 

endmodule : tb_top

