$devbase = $env:DEVBASE
$env:ANT_HOME = "$devbase\apps\ant"
$env:ECLIPSE_HOME = "$devbase\apps\eclipse"
$env:JAVA_HOME = "$devbase\apps\java\jdk1.8.0_92"
$env:NUNIT_HOME = "$devbase\apps\nunit"

$env:SDKDIR = "$devbase\sdk"
$env:MFSOLARROOT = "$devbase\solar"
$env:MFSNK="$devbase\svn\vside\misc\win\snkeys\MicroFocus.snk"

$env:PATH = "$env:NUNIT_HOME\bin\net-2.0;$env:PATH"
