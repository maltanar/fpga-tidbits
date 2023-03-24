// See README.md for license details.

ThisBuild / scalaVersion     := "2.13.8"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "com.github.erlingrj"

lazy val fpgatidbits = (project in file("."))
  .settings(
    name := "fpgatidbits",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.5.5",
      "edu.berkeley.cs" %% "chiseltest" % "0.5.5" % "test",
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit"
    ),
    testOptions ++= Seq(
      //      Tests.Argument("-oF") // Dont truncate stack trace
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.5" cross CrossVersion.full),
  )

