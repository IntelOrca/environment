$envbase = $Script:PSScriptRoot
$env:DEVBASE = "G:"

# Import modules
$moduleIncludeDirectory = "$envbase\include"
$modulesToInclude = Get-ChildItem $moduleIncludeDirectory -Filter *.ps1
foreach ($module in $modulesToInclude)
{
    Import-Module $module.FullName
}

function vsdevcmd
{
    Call-Batch "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"
}

# Micro Focus profile
. $envbase\mf.ps1

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
