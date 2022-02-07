module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;

  // YAPP Interface to the DUT
  yapp_if in0(
    clock, 
    reset
  );

  // CLKGEN module generates clock
  clkgen clkgen (
    .clock          ,
    .run_clock      ,
    .clock_period
  );

  clock_and_reset_if clk_reset_if (
    .clock          ,
    .reset          ,
    .run_clock      ,
    .clock_perion
  );

  hbus_if hbus_if (
      clock,
      reset
  );

  channel_if ch0(clock, reset);
  channel_if ch1(clock, reset);
  channel_if ch2(clock, reset);

  yapp_router dut(
    .reset      (   reset             ),
    .clock      (   clock             ),
    .error      (                     ),
    // YAPP interface
    .in_data    (   in0.in_data       ),
    .in_data_vld(   in0.in_data_vld   ),
    .in_suspend (   in0.in_suspend    ),
    // Output Channels
    //Channel 0
    .data_0     (   ch0.data          ),
    .data_vld_0 (   ch0.data_vld      ),
    .suspend_0  (   ch0.suspend       ),
    //Channel 1
    .data_1     (   ch1.data          ),
    .data_vld_1 (   ch1.data_vld      ),
    .suspend_1  (   ch1.suspend       ),
    //Channel 2
    .data_2     (   ch2.data          ),
    .data_vld_2 (   ch2.data_vld      ),
    .suspend_2  (   ch2.suspend       ),
    // HBUS Interface 
    .haddr      (   hbus_if.haddr     ),
    .hdata      (   hbus_if.hdata_w   ),
    .hen        (   hbus_if.hen       ),
    .hwr_rd     (   hbus_if.hwr_rd    )
  
  );

endmodule
