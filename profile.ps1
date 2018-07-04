$envbase = $Script:PSScriptRoot

# Import modules
Get-ChildItem "$envbase\include" -Filter *.ps1 | Select-Object -ExpandProperty FullName | Import-Module

# Common to all profiles
$env:PATH = "$env:PATH;C:\Program Files\git\usr\bin"
$env:PATH = "$home\bin;$env:PATH"
foreach ($binDirectory in (Get-ChildItem -Directory "$home\bin" -ErrorAction SilentlyContinue))
{
    $env:PATH = $binDirectory.FullName + ";$env:PATH"
}

$defaultProfileName = "$envbase\profiles\$env:COMPUTERNAME\$env:COMPUTERNAME.ps1"
if (Test-Path -PathType Leaf $defaultProfileName)
{
    . $defaultProfileName
}
else
{
    # Micro Focus profile
    . $envbase\profiles\mf\mf.ps1
}

# Set prompt to show just current directory name
function global:prompt
{
    $cwd = [System.IO.Path]::GetFileName((Get-Location))
    if ($cwd -eq "")
    {
        $cwd = "\"
    }
    Write-Host -NoNewline "PS "
    Write-Host -NoNewline -ForegroundColor DarkCyan $cwd
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue)
    {
        $GitPromptSettings.EnableWindowTitle = $null
        Write-VcsStatus
    }
    return " "
}

# Command prompt overrides
function dir { cmd /c dir $args }
function mklink { cmd /c mklink $args }
function which { cmd /c where $args }

# Aliases
Remove-Item alias:dir
Set-Alias call Call-Batch
Set-Alias grep Select-String
Set-Alias touch New-Item

# Improve history up/down completion
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key CTRL+U -Function DeleteLineToFirstChar
