$envbase = $Script:PSScriptRoot

# Import modules
Get-ChildItem "$envbase\include" -Filter *.ps1 | Select-Object -ExpandProperty FullName | Import-Module

# Common to all profiles
$env:PATH = "$env:PATH;C:\Program Files\git\usr\bin"
$env:PATH = "$env:PATH;C:\Program Files\7-Zip"
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
    $origLastExitCode = $LASTEXITCODE
    $cwd = [System.IO.Path]::GetFileName($ExecutionContext.SessionState.Path.CurrentLocation)
    if ($cwd -eq "")
    {
        $cwd = "\"
    }
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue)
    {
        $prompt += Write-Prompt "PS "
        $prompt += Write-Prompt "$($cwd)" -ForegroundColor DarkCyan
        $prompt += Write-VcsStatus
    }
    else
    {
        Write-Host -NoNewline "PS "
        Write-Host -NoNewline -ForegroundColor DarkCyan $cwd
    }
    $prompt += " "
    $LASTEXITCODE = $origLastExitCode
    return $prompt
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
Set-Alias l Get-ChildItem
Set-Alias ll Get-ChildItem
Set-Alias .. cd..

# Improve history up/down completion
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key CTRL+U -Function DeleteLineToFirstChar

# Use newer SSL protocol (some sites prohibit the default one)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Tell less we can display UTF-8
$env:LESSCHARSET = "utf-8"

Set-Title "PowerShell"
Set-PoshPrompt -Theme C:\Users\Ted\env\config\.mytheme.omp.json
