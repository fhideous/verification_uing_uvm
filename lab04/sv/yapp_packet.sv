
typedef enum bit { BAD_PARITY, GOOD_PARITY } parity_type_e;

class yapp_packet extends uvm_sequence_item;

  rand bit [5:0]  length;
  rand bit [1:0]  addr;
  rand bit [7:0]  payload [];
  bit      [7:0]  parity;

  rand parity_type_e parity_type;  
  rand int packet_delay;
  // UVM macros for built-in automation - These declarations enable automation
  // of the data_item fields 
  `uvm_object_utils_begin (yapp_packet)
    `uvm_field_int          (length,       UVM_ALL_ON)
    `uvm_field_int          (addr,         UVM_ALL_ON)
    `uvm_field_array_int    (payload,      UVM_ALL_ON)
    `uvm_field_int          (parity,       UVM_ALL_ON)
    `uvm_field_enum         (parity_type_e, parity_type, UVM_ALL_ON)
    `uvm_field_int          (packet_delay, UVM_ALL_ON | UVM_DEC | UVM_NOCOMPARE)
  `uvm_object_utils_end

  function new (string name = "yapp_packet");
    super.new(name);
  endfunction : new

  constraint length_size    { length > 0; length < 64; }
  constraint payload_size   { length == payload.size(); }
  constraint packet_constr  { packet_delay >= 0; packet_delay < 20; }
  constraint parity_distr   { parity_type dist {BAD_PARITY := 1, GOOD_PARITY := 5}; }
  constraint addr_constr    { addr != 'b11; }

 // calc_parity return byte parity of header and array payloads
 // header = {lenth, addr}  // 8 bit
 // payload - array of len = "length" 8-bit elements; 
  function bit [7:0] calc_parity();
    calc_parity = {length, addr};
    for (int i = 0; i< length; i++) 
      calc_parity = calc_parity ^ payload[i];
  endfunction : calc_parity

  function void set_parity();
    parity = calc_parity();
    if (parity_type == BAD_PARITY)
      parity++;
  endfunction : set_parity

  // start always after rendomize of all variables 
  function void post_randomize();
    set_parity();
  endfunction : post_randomize

endclass: yapp_packet

class short_yapp_packet extends yapp_packet;

`uvm_object_utils(short_yapp_packet)

  function new(string name = "short_yapp_packet");
    super.new(name);
  endfunction : new

  constraint short_len    { length < 15;   } 
  constraint short_addr   { addr != 'b10;  } 

endclass : short_yapp_packet