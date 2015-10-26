scalaVersion := "2.11.6"

libraryDependencies += "edu.berkeley.cs" %% "chisel" % "latest.release"

unmanagedSourceDirectories in Compile <++= baseDirectory { base =>
  Seq(
    base / "common",
    base / "interfaces",
    base / "profiler",
    base / "streams",
    base / "dma",
    base / "on-chip-memory",
    base / "sim-utils",
    base / "regfile",
    base / "testbenches/on-chip-memory",
    base / "testbenches/streams",
    base / "testbenches/sim-utils",
    base / "testbenches/wrapper",
    base / "platform-wrapper",
    base / "platform-wrapper/convey",
    base / "platform-wrapper/axi",
    base / "platform-wrapper/tests"
  )
}
