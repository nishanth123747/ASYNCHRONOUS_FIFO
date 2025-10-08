`include "define.sv"
`include "uvm_macros.svh"

interface asyc_fifo_inf(input wclk, rclk, wrst_n, rrst_n);
 
  // inputs
  bit   [`DSIZE-1:0]  wdata;
  bit                 winc;
  bit                 rinc;
  
  // outputs
  logic               wfull;
  logic               rempty;
  logic  [`DSIZE-1:0] rdata;

  // Write-driver
  clocking wr_drv_cb @(posedge wclk);
    default input #0 output #0;
    input  wfull, wrst_n;
    output wdata, winc;
  endclocking
  
  // Read-driver
  clocking rd_drv_cb @(posedge rclk);
    default input #0 output #0;
    input  rdata, rempty, rrst_n;
    output rinc;
  endclocking
  
  // Write-monitor
  clocking wr_mon_cb @(posedge wclk);
    default input #0 output #0;
    input  wdata, winc, wfull, wrst_n;
  endclocking
  
  // Read-monitor
  clocking rd_mon_cb @(posedge rclk);
    default input #0 output #0;
    input  rinc, rdata, rempty, rrst_n;
  endclocking

  modport WR_DRV (clocking wr_drv_cb, input wrst_n);
  modport WR_MON (clocking wr_mon_cb, input wrst_n);
  modport RD_DRV (clocking rd_drv_cb, input rrst_n);
  modport RD_MON (clocking rd_mon_cb, input rrst_n);

endinterface

