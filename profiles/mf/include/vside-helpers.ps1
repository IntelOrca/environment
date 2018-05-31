function exp { devenv /nosplash /rootsuffix exp $args }
function buildvsix { Light-Build .\src\MicroFocus.VSIX.ProductPackage\MicroFocus.VSIX.ProductPackage.csproj }
function testenv { call "$env:MFSOLARROOT\cobdir\Debug\x86\CreateTestEnv.bat" }
function nunitscan { & $env:DEVBASE\apps\nunitscan\nunitscan\bin\Release\nunitscan.exe $args }
function cleartestresults
{
    @("test work","results") | ForEach-Object {
        if (Test-Path $_) { Remove-Item -Force -Recurse $_ }
    }
}
function vs { cmd /c "set MFTRACE_CONFIG= && devenv /nosplash $args" }

function svnlog
{
    param([String]$path = ".")
    TortoiseProc.exe /command:log /path:$path
}

function svnbrowse
{
    param([String]$path = "http://nwb-svn/mf")
    TortoiseProc.exe /command:repobrowser /path:$path
}
