function exp { devenv /nosplash /rootsuffix exp /command "Tools.COBDIRExpSetEnv" $args }
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

function patch-exp
{
    param([String]$path)

    # Get extension directory
    $extensionDir = Resolve-Path "$env:LOCALAPPDATA\Microsoft\VisualStudio\*_*Exp"
    $ourExtensionDir = Get-ChildItem "$extensionDir\Extensions\Micro Focus\Micro Focus COBOL" | Select-Object -Last 1

    # Get source item
    $src = Get-ChildItem $path

    # Copy file to extension
    Copy-Item $src.FullName $ourExtensionDir.FullName
}

function symlink-exp
{
    param([String]$path)

    # Get extension directory
    $extensionDir = Resolve-Path "$env:LOCALAPPDATA\Microsoft\VisualStudio\*_*Exp"
    $ourExtensionDir = Get-ChildItem "$extensionDir\Extensions\Micro Focus\Micro Focus COBOL" | Select-Object -Last 1

    # Get target item
    $target = Get-ChildItem $path
    $src = Join-Path $ourExtensionDir.FullName $target.Name

    # Create symbolic link
    cmd /c "del ""$src"""
    mklink $src $target.FullName
}
