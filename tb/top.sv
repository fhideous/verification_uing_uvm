
module top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import yapp_pkg::*;

  yapp_packet packet;
  yapp_packet copy_packet;
  yapp_packet clone_packet;

  initial begin

  copy_packet = new("copy_packet");

  for (int i=0; i<3; i++) begin
    packet = new( $sformatf("packet_%0d", i) );
    packet.randomize();
    packet.print(uvm_default_table_printer);
  end

  $display("\nCOPY");
  copy_packet.copy(packet);
  copy_packet.print();

 
  $display("CLONE");
  copy_packet.compare(packet);
  copy_packet.randomize();
  copy_packet.compare(packet);
  
  $display("CLONE");
  $cast(clone_packet, packet.clone()); 
  clone_packet.print();



end

endmodule : top

