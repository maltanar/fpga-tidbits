package fpgatidbits.hlstools
import sys.process._
import java.io.File

// Collection of utilities for Vivado HLS

object TidbitsHLSTools {
  // quick-and-dirty single file HLS synthesis
  def hlsToVerilog(
    inFile: String,
    outDir: String,
    synDir: String,
    projName: String,
    topFxnName: String,
    inclDirs: Seq[String] = Seq(),
    fpgaPart: String = "xc7z020clg400-1",
    nsClk: String = "5.0"
  ) = {
    // get path to hls_syn.tcl
    val synthScriptPath = getClass.getResource("/script/hls_syn.tcl").getPath
    // need to provide include dirs as a single string argument, parsing
    // done in tcl. note: dirs here should have no spaces!
    val inclDirString = inclDirs.mkString(" ")
    // call the actual synthesis script
    val cmdline = Seq(
      "vivado_hls",
      "-f", synthScriptPath,
      "-tclargs", projName, inFile, fpgaPart, nsClk, topFxnName, inclDirString
    )
    val status = Process(cmdline, new File(synDir)) ! ProcessLogger(stdout append _+"\n", stderr append _+"\n")
    // copy results to outDir
    s"cp -a $synDir/$projName/sol1/impl/verilog/. $outDir/".!!
  }
}
