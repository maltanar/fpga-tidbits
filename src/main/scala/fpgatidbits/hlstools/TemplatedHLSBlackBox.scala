package fpgatidbits.hlstools

import Chisel._

// helper class to derive BlackBox modules that correspond to Vivado HLS
// templated functions which come with a macro-based wrapper. Suppose that
// you have the following templated Vivado HLS module:
// template <int A, int B> myTemplatedHLSModule(runtime args) {...}
// This should have a wrapper that looks like:
// #include "myTemplateDefines.h"
// void myTemplatedHLSModuleWrapper(runtime args) {
//   <top-level interface pragmas>
//   myTemplatedHLSModule<TEMPLATE_PARAM_A, TEMPLATE_PARAM_B>(runtime args);
// }
// The TemplatedHLSBlackBox class can now be used to make a Chisel BlackBox
// whose generateTemplateDefines function generates the myTemplateDefines.h
// The hlsTemplateParams member must map template parameter names to values,
// where each parameter name will be prefixed with templateParamPrefix
// for instance, hlsTemplateParams = ("A" -> "12", "B" -> "55") will generate:
// #define TEMPLATE_PARAM_A 12
// #define TEMPLATE_PARAM_B 55

abstract class TemplatedHLSBlackBox() extends BlackBox {
  def hlsTemplateParams: Map[String, String]
  val templateParamPrefix = "TEMPLATE_PARAM_"

  def generateTemplateDefines(fileName: String): String = {
    val templateDefines = generateTemplateDefines()
    // write the generated define string into a file
    import java.io._
    val writer = new PrintWriter(new File(fileName))
    writer.write(templateDefines)
    writer.close()
    return templateDefines
  }

  def generateTemplateDefines(): String = {
    // build and return the define string by serializing the pairs as
    // given by hlsTemplateParams
    var templateDefines: String = ""
    for((name, value) <- hlsTemplateParams) {
      templateDefines += s"#define ${templateParamPrefix}${name} ${value}\n"
    }
    return templateDefines
  }
}
