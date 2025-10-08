`include "uvm_macros.svh"
package fifo_pkg;
import uvm_pkg::*;
    `include "define.sv"

  `include "asyc_fifo_wrt_seq_item.sv"
  `include "asyc_fifo_rd_seq_item.sv"

  `include "asyc_fifo_wrt_sequence.sv"
  `include "asyc_fifo_rd_sequence.sv"

  `include "asyc_fifo_wrt_sequencer.sv"
  `include "asyc_fifo_rd_sequencer.sv"
  `include "asyc_fifo_wrt_driver.sv"
  `include "asyc_fifo_rd_driver.sv"
  `include "asyc_fifo_wrt_monitor.sv"
  `include "asyc_fifo_rd_monitor.sv"


  `include "asyc_fifo_wrt_agent.sv"
  `include "asyc_fifo_rd_agent.sv"
  `include "asyc_fifo_scoreboard.sv"
  `include "asyc_fifo_subscriber.sv"
  `include "asyc_fifo_virtual_sequencer.sv"
  `include "asyc_fifo_virtual_sequence.sv"

    `include "asyc_fifo_environment.sv"
  `include "asyc_fifo_test.sv"

endpackage

