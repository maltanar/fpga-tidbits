package fpgatidbits.interconnect

import Chisel._
import fpgatidbits.axi._
import fpgatidbits.streams._

// connect an AXI-lite master interface to multiple AXI-lite slaves,
// routing the requests based on the address. note that the addresses are NOT
// rebased when going into the slaves.
class AXILiteSwitch(
  addrBits: Int, dataBits: Int, // AXI lite interface widths
  numSlaves: Int,               // number of slaves to connect to
  routingFxn: UInt => UInt      // map address to slave number (0...numSlaves-1)
) extends Module {
  val io = new Bundle {
    val in = new AXILiteSlaveIF(addrBits, dataBits)
    val out = Vec.fill(numSlaves) { new AXILiteMasterIF(addrBits, dataBits) }
  }

  // route incoming read commands to appropriate slave, based on the output
  // of the routingFxn (applied on the incoming address)
  io.in.readAddr <> DecoupledOutputDemux(
    sel = routingFxn(io.in.readAddr.bits.addr),
    chans = io.out.map(x => x.readAddr)
  )

  // writes are a bit trickier, since we have to ensure that the write data
  // (which has no routing indicator) follows the same path as the write request
  // to achieve this, we force the incoming write requests and data to go in
  // lockstep, with queueing so that they can arrive at different times:

  val syncWrIn = Module(new StreamSync(
    genA = io.in.writeAddr.bits, genB = io.in.writeData.bits,
    queueInput = true, queueOutput = true
  )).io
  io.in.writeAddr <> syncWrIn.inA
  io.in.writeData <> syncWrIn.inB

  // to ensure lockstep on the output, we need a number of StreamSync comps,
  // this time with output queueing so that the slaves can pop the write addr
  // and data separately if they want to:
  val syncWrOut = Vec.fill (numSlaves) { Module(new StreamSync(
    genA = io.in.writeAddr.bits, genB = io.in.writeData.bits,
    queueOutput = true
  )).io }

  for(i <- 0 until numSlaves) {
    syncWrOut(i).outA <> io.out(i).writeAddr
    syncWrOut(i).outB <> io.out(i).writeData
  }

  // finally, we connect the synchronizers using a pair of DecoupledOutputDemux:
  // write address
  syncWrIn.outA <> DecoupledOutputDemux(
    sel = routingFxn(syncWrIn.outA.bits.addr),
    chans = syncWrOut.map(x => x.inA)
  )
  // write data
  syncWrIn.outB <> DecoupledOutputDemux(
    sel = routingFxn(syncWrIn.outA.bits.addr),  // possible w/addr-data sync
    chans = syncWrOut.map(x => x.inB)
  )

  // use round-robin arbitration between incoming read data and write resps
  val arbReadData = Module(new RRArbiter(io.in.readData.bits, numSlaves)).io
  val arbWriteRsp = Module(new RRArbiter(io.in.writeResp.bits, numSlaves)).io

  for(i <- 0 until numSlaves) {
    io.out(i).readData <> arbReadData.in(i)
    io.out(i).writeResp <> arbWriteRsp.in(i)
  }
  arbReadData.out <> io.in.readData
  arbWriteRsp.out <> io.in.writeResp
}
