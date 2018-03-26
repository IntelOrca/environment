function Svn-Branch
{
    param([Parameter(Mandatory=$true)][String] $Name,
          [Parameter(Mandatory=$true)][String] $Message,
          [Parameter(Mandatory=$true)][String] $Release)

    $baseUrl   = "http://nwb-svn/mf/vside/vscore"
    $trunkUrl  = "$baseUrl/branches/VisualCOBOL-R$Release"
    $branchUrl = "$baseUrl/private-branches/VisualCOBOL-R$Release/$Name"

    svn copy $trunkUrl $branchUrl -m $Message
    if ($LASTEXITCODE -eq 0)
    {
        Write-Host "Branched successfully to: $branchUrl" -ForegroundColor Green
    }
}
