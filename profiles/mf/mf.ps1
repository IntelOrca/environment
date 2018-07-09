Get-ChildItem "$Script:PSScriptRoot\include" -Filter *.ps1 | Select-Object -ExpandProperty FullName | Import-Module

$env:DEVBASE = "G:"
$devbase = $env:DEVBASE
$env:ANT_HOME = "$devbase\apps\ant"
$env:ECLIPSE_HOME = "$devbase\apps\eclipse"
$env:JAVA_HOME = "$devbase\apps\java\jdk1.8.0_92"
$env:NUNIT_HOME = "$devbase\apps\nunit"

$env:SDKDIR = "$devbase\sdk"
$env:MFSOLARROOT = "$devbase\solar"
$env:MFSNK="$devbase\svn\vside\misc\win\snkeys\MicroFocus.snk"

$env:PATH = "$env:ANT_HOME\bin\;$env:PATH"
$env:PATH = "$env:NUNIT_HOME\bin\net-2.0;$env:PATH"
$env:PATH = "$devbase\apps\ilspy;$env:PATH"
$env:PATH = "$devbase\apps\jd;$env:PATH"
$env:PATH = "$devbase\apps\nuget;$env:PATH"
$env:PATH = "$devbase\apps\sysinternals;$env:PATH"

if (Test-Path -PathType Container "C:\Users\Public\Documents\Micro Focus\Enterprise Developer")
{
    $samples = "C:\Users\Public\Documents\Micro Focus\Enterprise Developer\Samples"
}
elseif (Test-Path -PathType Container "C:\Users\Public\Documents\Micro Focus\Visual COBOL")
{
    $samples = "C:\Users\Public\Documents\Micro Focus\Visual COBOL\Samples"
}
