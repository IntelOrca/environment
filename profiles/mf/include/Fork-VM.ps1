$DEFAULT_VHD_PATH = "F:\vhds";

function Fork-VM
{
    param([Parameter(Mandatory=$true)][String] $Name,
          [String] $Parent)

    $ErrorActionPreference = "Stop"
    New-Item -ItemType Directory "$DEFAULT_VHD_PATH\auto" -Force > $null
    $vhdPath = "$DEFAULT_VHD_PATH\auto\vm-$Name.vhdx"

    New-VHD -Differencing -ParentPath $Parent -Path $vhdPath > $null
    New-VM -Name $Name -VHDPath $vhdPath -Generation 2 -SwitchName "Default Switch" > $null
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

    $vhdPath = "$DEFAULT_VHD_PATH\auto\vm-$name.vhdx"
    
    Stop-VM $Name -TurnOff
    Remove-VM $Name -Force
    Remove-Item $vhdPath -Force
}
