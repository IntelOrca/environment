function Fork-VM
{
    param([Parameter(Mandatory=$true)][String] $Name,
          [String] $Parent = "E:\vm\Win10-1803.vhdx")

    $ErrorActionPreference = "Stop"
    New-Item -ItemType Directory "E:\vm\auto" -Force > $null
    $vhdPath = "E:\vm\auto\vm-$Name.vhdx"

    New-VHD -Differencing -ParentPath $Parent -Path $vhdPath > $null
    New-VM -Name $Name -VHDPath $vhdPath -Generation 2 -SwitchName Wireless > $null
    Set-VM $Name -ProcessorCount 4 `
                 -CheckpointType Production `
                 -AutomaticCheckpointsEnabled $false
    Start-VM $Name

    vmconnect localhost $Name
}

function Delete-VM
{
    param([Parameter(Mandatory=$true)][String] $Name)

    $ErrorActionPreference = "Stop"

    $vhdPath = "E:\vm\auto\vm-$name.vhdx"
    
    Stop-VM $Name -TurnOff
    Remove-VM $Name -Force
    Remove-Item $vhdPath -Force
}
