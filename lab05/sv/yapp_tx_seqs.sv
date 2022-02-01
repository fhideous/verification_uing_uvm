class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  `uvm_object_utils(yapp_base_seq)

  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : yapp_base_seq

// ------------------------------
// SEUENCE : 5 packets
// ------------------------------

class yapp_5_packets extends yapp_base_seq;

  `uvm_object_utils(yapp_5_packets)

  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask

endclass : yapp_5_packets

// ------------------------------
// SEUENCE : Sending one packet, addr == 1
// ------------------------------

class yapp_1_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_1_seq)

  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)
    `uvm_do_with(req, {req.addr == 2'b01;})
  endtask

endclass : yapp_1_seq

// ------------------------------
// SEUENCE : Three packets with incrementing addresses
// ------------------------------

class yapp_012_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_012_seq)

  function new(string name="yapp_012_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)
    `uvm_do_with(req, {req.addr == 2'b00;})
    `uvm_do_with(req, {req.addr == 2'b01;})
    `uvm_do_with(req, {req.addr == 2'b10;})
  endtask

endclass : yapp_012_seq

// ------------------------------
// SEUENCE : Three packets to address 1
// ------------------------------

class yapp_111_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_111_seq)

  function new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)
    repeat(5)
      `uvm_do_with(req, {req.addr == 2'b01;})

  endtask

endclass : yapp_111_seq

// ------------------------------
// SEUENCE : Two packets to the same (random) address
// ------------------------------

class yapp_repeat_addr_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_repeat_addr_seq)

  function new(string name="yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  rand bit [1:0] seq_addr;
  constraint legal_seq_addr {seq_addr != 'b11;}

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_repeat_addr_seq sequence", UVM_LOW)
    repeat(2)
      `uvm_do_with(req, {req.addr == seq_addr;})

  endtask

endclass : yapp_repeat_addr_seq

// ------------------------------
// SEUENCE : Single packet with incrementing payload data
// ------------------------------

class yapp_incr_payload_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_incr_payload_seq)

  function new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction

  rand bit [1:0] seq_addr;
  constraint legal_seq_addr {seq_addr != 'b11;}

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)
      `uvm_do_with(req, { foreach (payload[i]) payload[i] == i ; } )

  endtask

endclass : yapp_incr_payload_seq
