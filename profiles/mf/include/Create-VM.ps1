function Create-VM
{
    param([Parameter(Mandatory=$true)][String] $Name,
          [Parameter(Mandatory=$true)][String] $VhdPath)

    $ErrorActionPreference = "Stop"

    New-VM -Name $Name -VHDPath $VhdPath -Generation 2 -SwitchName Wireless > $null
    Set-VM $Name -ProcessorCount 4 `
                 -CheckpointType Production `
                 -AutomaticCheckpointsEnabled $false
    Start-VM $Name

    vmconnect localhost $Name
}
