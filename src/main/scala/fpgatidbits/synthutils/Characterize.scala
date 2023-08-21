// Copyright (c) 2018 Norwegian University of Science and Technology (NTNU)
//
// BSD v3 License
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// * Neither the name of [project] nor the names of its
//   contributors may be used to endorse or promote products derived from
//   this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package fpgatidbits.synthutils

import sys.process._
import scala.sys.process._
import java.io._
import scala.collection.mutable.ArrayBuffer
import chisel3._
import fpgatidbits.TidbitsMakeUtils.fpgaPartMap

import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

// Utilities for estimating FPGA resource and Fmax from a parametrizable Chisel
// Module. Uses the oh-my-xilinx scripts to perform Vivado out-of-context
// synthesis, place and route.
// Facilitates design space exploration using the characterizePoint
// and characterizeSpace functions of the VivadoSynth object.

// the Module parameters that will be used for characterization should inherit
// PrintableParam so that the parameters of each design point can be summarized
// in a human-readable fashion.
abstract class PrintableParam() {
  def headersAsList(): List[String] // parameter names as a list of strings
  def contentAsList(): List[String] // parameter values as list of strings
}

// bundled up numbers/results from characteriation
class CharacterizeResult(
  val lut: Int,
  val lutram: Int,
  val reg: Int,
  val dsp: Int,
  val bram: Int,
  val target_ns: Double,
  val fmax_mhz: Double) extends PrintableParam {
  def printSummary() = {
    println(s"$lut LUTs, $reg FFs, $bram BRAMs, $dsp DSP slices, $fmax_mhz MHz")
  }

  def headersAsList(): List[String] = {
    return List("LUT", "FF", "DSP", "LUTRAM","BRAM", "Fmax (MHz)")
  }

  def contentAsList(): List[String] = {
    return List(lut, reg, dsp, lutram, bram, fmax_mhz).map(_.toString)
  }
}

object VivadoSynth {
  // given an instantiation function instFxn that generates a Chisel module
  // from parameters p, return the FPGA synthesis results

  def writeVerilogToFile(verilog: String, path: String) = {
    import java.io._
    val fname = path
    val f = new File(fname)
    if (!f.exists()) {
      f.getParentFile.mkdirs
      f.createNewFile()
    }
    val writer = new PrintWriter(f)
    writer.write(verilog)
    writer.close()

  }

  def characterizePoint[Tp <: PrintableParam, Tm <: RawModule](
    p: Tp, // printable parameters for instantiation of module
    instFxn: Tp => Tm, // function that instantiates module from parameters
    path: String, // directory to create Vivado proj in
    fpgaPart: String, // FPGA part to run characterization for
    topModuleName: String
  ): CharacterizeResult = {
    val args = Array[String]("--targetDir", path)
    println("Now exploring design point with parameters:")
    println(p.headersAsList().mkString("\t"))
    println(p.contentAsList().mkString("\t"))
    // call Chisel to generate Verilog
    val verilogString = (new chisel3.stage.ChiselStage).emitVerilog(instFxn(p))
    writeVerilogToFile(verilogString, path+"/"+topModuleName + ".v")

    // run Nachiket Kapre's quick synthesis-and-characterization scripts
    var ret: CharacterizeResult = new CharacterizeResult(
      lut = 0, reg = 0, bram = 0, lutram=0, dsp = 0, target_ns = 0, fmax_mhz = 0)
    try {
      val cmd = s"bash -c \"$$OHMYXILINX/vivadocompile.sh ${topModuleName} clock ${fpgaPart}\""
      println(s"Executing `$cmd")
      val proc = Process(cmd, new File(path)).!
      val result_res = Process(s"cat results_$topModuleName/res.txt", new File(path)).!!
      // do some string parsing to pull out the numbers
      val result_lines = result_res.split("\n")
      val luts_fields = result_lines(0).split('=').map(_.trim)
      val lutrams_fields = result_lines(1).split('=').map(_.trim)
      val regs_fields = result_lines(2).split('=').map(_.trim)
      val dsps_fields = result_lines(3).split('=').map(_.trim)
      val bram_fields = result_lines(4).split('=').map(_.trim)
      val slack_fields = result_lines(9).split('=').map(_.trim)
      val slack_ns: Double = if (slack_fields.length <= 1) 0 else slack_fields(1).toDouble
      val req_ns: Double = 2.0 // TODO should pull from vivadocompile.xdc
      val fmax_mhz: Double = if (slack_fields.length <= 1) 0 else 1000.0 / (req_ns - slack_ns)

      ret = new CharacterizeResult(
        lut = luts_fields(1).toInt, lutram=lutrams_fields(1).toInt, reg = regs_fields(1).toInt,
        bram = bram_fields(1).toInt,
        dsp = dsps_fields(1).toInt, target_ns = req_ns, fmax_mhz = fmax_mhz)
    } catch {
      case error: Throwable => {
        println("Characterization ERROR: something went wrong. Synthesis failed, probably out of resources")
        println(error.getMessage)
        println(error.printStackTrace())
      }
    }

    println("Results for parameters:")
    println(ret.headersAsList().mkString("\t"))
    println(ret.contentAsList().mkString("\t"))
    return ret
  }

  // given an instantiation function instFxn that generates a Chisel module
  // from parameters, and a space of parameters, return FPGA synth results
  def characterizeSpace[Tp <: PrintableParam, Tm <: Module](
    param_space: Seq[Tp], // space of parameters to explore
    instFxn: Tp => Tm, // instantiation function as in characterizePoint
    path: String, // directory to create Vivado proj in
    log: String, // filename for log
    // FPGA part to run characterization for
    fpgaPart: String = fpgaPartMap("PYNQZ1"),
    topModuleName: String): Seq[(Tp, CharacterizeResult)] = {
    // TODO maybe consider parallelization here to make things go faster?
    val logfile = new PrintWriter(new File(log))
    logfile.println("Design Space Exploration Results")
    logfile.println("===================================")
    var headers_written = false
    var design_space = ArrayBuffer[(Tp, CharacterizeResult)]()
    for (p <- param_space) {
      val res = characterizePoint(p, instFxn, path, fpgaPart, topModuleName)
      // write headers (description of parameters)
      if (!headers_written) {
        val headers = param_space(0).headersAsList() ++ res.headersAsList()
        logfile.println(headers.mkString("\t"))
        headers_written = true
      }
      // write parameter and result data
      val content = p.contentAsList() ++ res.contentAsList()
      logfile.println(content.mkString("\t"))
      logfile.flush()
      val design_point: (Tp, CharacterizeResult) = (p, res)
      design_space += design_point
    }

    logfile.close()
    return design_space.toSeq
  }
}
