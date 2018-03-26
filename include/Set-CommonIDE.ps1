function Set-CommonIDE
{
    param([Parameter(Mandatory=$true)][String] $Checkout)

    $virtualPath  = "$env:DEVBASE\svn\vside\commonide"
    $absolutePath = "$env:DEVBASE\svn\commonide\$Checkout"

    if (Test-Path $absolutePath)
    {
        New-Item -Force -ItemType SymbolicLink -Path (Split-Path $virtualPath) -Name (Split-Path -Leaf $virtualPath) -Value $absolutePath > $null
    }
    else
    {
        Write-Host "$absolutePath not found" -ForegroundColor Red
    }
}

function Build-CommonIDE
{
    pushd "$env:DEVBASE\svn\vside"
        msbuild buildall.proj /nologo /t:CleanCommonIDE /v:m
        msbuild buildall.proj /nologo /t:BuildCommonIDE /p:Configuration=Debug /m /v:m
    popd
}
