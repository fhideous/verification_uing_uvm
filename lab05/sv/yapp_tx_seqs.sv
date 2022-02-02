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
    repeat(3)
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



// ------------------------------
// SEUENCE : execute random number of packates 
// ------------------------------

class yapp_rnd_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_rnd_seq)

  function new(string name="yapp_rnd_seq");
    super.new(name);
  endfunction

  rand int count;

  constraint count_limit { count inside { [1:10] }; }

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_rnd_seq sequence", UVM_LOW)
    repeat(count)
      `uvm_do(req)
  endtask

endclass : yapp_rnd_seq

// ------------------------------
// SEUENCE : execute 6 packates, based on previous class
// ------------------------------

class six_yapp_seq extends yapp_base_seq;
  
  `uvm_object_utils(six_yapp_seq)

  function new(string name="six_yapp_seq");
    super.new(name);
  endfunction

  yapp_rnd_seq rnd_seq;

  virtual task body();
    `uvm_info(get_type_name(), "Executing six_yapp_seq sequence", UVM_LOW)
    `uvm_do_with(rnd_seq, {count == 6; })
  endtask

endclass : six_yapp_seq

// ------------------------------
// SEUENCE : single sequence which executes previous sequences
// ------------------------------

class yapp_exhaustive_seq extends yapp_base_seq;
  
  `uvm_object_utils(yapp_exhaustive_seq)

  function new(string name="yapp_exhaustive_seq");
    super.new(name);
  endfunction

  yapp_012_seq y012;
  yapp_1_seq y1;
  yapp_111_seq y111;
  yapp_repeat_addr_seq yaddr;
  yapp_incr_payload_seq yinc;
  six_yapp_seq syp;

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)
    `uvm_do(y012)
    `uvm_do(y1)
    `uvm_do(y111)
    `uvm_do(yaddr)
    `uvm_do(yinc)
    `uvm_do(syp)
  endtask

endclass : yapp_exhaustive_seq