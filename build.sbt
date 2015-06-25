scalaVersion := "2.10.4"

addSbtPlugin("com.github.scct" % "sbt-scct" % "0.2")

libraryDependencies += "edu.berkeley.cs" %% "chisel" % "latest.release"

unmanagedSourceDirectories in Compile <++= baseDirectory { base =>
  Seq(
    base / "common",
    base / "interfaces",
    base / "profiler",
    base / "streams",
    base / "on-chip-memory",
    base / "testbenches/on-chip-memory"
  )
}
