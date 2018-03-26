function Set-VSEnterprise
{
    param([Parameter(Mandatory=$true)][String] $Checkout)

    $virtualPath  = "$env:DEVBASE\svn\vside\vsenterprise"
    $absolutePath = "$env:DEVBASE\svn\vsenterprise\$Checkout"

    if (Test-Path $absolutePath)
    {
        New-Item -Force -ItemType SymbolicLink -Path (Split-Path $virtualPath) -Name (Split-Path -Leaf $virtualPath) -Value $absolutePath > $null
    }
    else
    {
        Write-Host "$absolutePath not found" -ForegroundColor Red
    }
}
