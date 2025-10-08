`include "define.sv"
`include "uvm_macros.svh"

interface inf(input wclk, rclk, wrst_n, rrst_n);
 
  // inputs
  bit   [`DSIZE-1:0]  wdata;
  bit                 winc;
  bit                 rinc;
  
  // outputs
  logic               wfull;
  logic               rempty;
  logic  [`DSIZE-1:0] rdata;

  // write-driver
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

property p1;
    @(posedge wclk) disable iff (!wrst_n)
      winc |-> !($isunknown(wdata));
  endproperty

  wdata_check:
    assert property (p1)
      $info("ASSERTION-1 PASSED: WDATA CHECK");
    else
      $error("ASSERTION-1 FAILED: WDATA CHECK");

  property p2;
    @(posedge rclk) disable iff (!rrst_n)
      (rinc && !rempty) |-> !($isunknown(rdata));
  endproperty

  rdata_check:
    assert property (p2)
      $info("ASSERTION-2 PASSED: RDATA CHECK");
    else
      $error("ASSERTION-2 FAILED: RDATA CHECK");


  property p3;
    @(posedge rclk) disable iff (!rrst_n)
      !(rempty && wfull);
  endproperty

  full_empty_check:
    assert property (p3)
      $info("ASSERTION-3 PASSED: FULL & EMPTY ");
    else
      $error("ASSERTION-3 FAILED: FULL & EMPTY");
//Reset behavior: when reset is low, FIFO should be empty, not full
  property p4;
    @(posedge wclk or posedge rclk)
      (!wrst_n || !rrst_n) |-> (wfull == 0 && rempty == 1);
  endproperty
    reset_check:
assert property (p4)
      $info("ASSERTION-4 PASSED: RESET CHECK");
      else
      $error("ASSERTION-4 FAILED: RESET CHECK");
//property p_empty_clears_on_write;
//  @(posedge wclk) disable iff (!wrst_n)
   //   (rempty && winc && !wfull) |=> !rempty;
 // endproperty
//  a_empty_clears_on_write: assert property (p_empty_clears_on_write)
 //   else $error("Empty flag not cleared after write to empty FIFO at %0t", $time);



endinterface
