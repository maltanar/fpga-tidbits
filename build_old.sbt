val chiselVersion = System.getProperty("chiselVersion", "latest.release")

val scalaVer = System.getProperty("scalaVer", "2.11.6")
resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)

lazy val fpgatidbitsSettings = Seq (
  version := "0.1",
  name := "fpgatidbits",

  scalaVersion := scalaVer,

  //libraryDependencies ++= ( if (chiselVersion != "None" ) ("edu.berkeley.cs" %% "chisel3" % chiselVersion) :: Nil; else Nil),


  libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.2.4",
    libraryDependencies += "edu.berkeley.cs" %% "chisel-iotesters" % "1.4.1",

 // libraryDependencies += "com.novocode" % "junit-interface" % "0.10" % "test",
//  libraryDependencies += "org.scalatest" %% "scalatest" % "2.2.4" % "test",
  libraryDependencies += "org.scala-lang" % "scala-compiler" % scalaVer
)

lazy val fpgatidbits = (project in file(".")).settings(fpgatidbitsSettings: _*)
