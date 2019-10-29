function Call-Batch
{
<#
.Synopsis
    Invokes a command and imports its environment variables.
    Author: Roman Kuzmin (inspired by Lee Holmes's Invoke-CmdScript.ps1)

.Description
    It invokes the specified CMD command and imports its environment variables
    to the current PowerShell session. The command is normally a configuration
    batch file without arguments or very simple arguments, e.g. arguments with
    spaces are troublesome.

    Command output is discarded. Use the switch Output in order to receive it.
    $LASTEXITCODE can be examined unless the switch Force is specified.

.Parameter Command
        Specifies a command being invoked, e.g. a configuration batch file.
        This string is the whole command text passed in cmd /c. Do not use
        redirection operators, they are used by the script.
.Parameter Output
        Tells to collect and return the command output.
.Parameter Force
        Tells to import variables even if the command exit code is not 0.

.Inputs
    None. Use the script parameters.
.Outputs
    None or the command output.

.Example
    >
    # Invoke vsvars32 and import its environment even if exit code is not 0
    Invoke-Environment '"%VS100COMNTOOLS%\vsvars32.bat"' -Force

    # Invoke Config.bat and show its output
    Invoke-Environment Config.bat -Output

.Link
    https://github.com/nightroman/PowerShelf
#>

param
(
    [string]$Script,
    [string]$Command,
    [switch]$Output = $true,
    [switch]$Force
)

if ($Script)
{
    $Command = """$Script"""
}

$stream = if ($Output) { ($temp = [IO.Path]::GetTempFileName()) } else { 'nul' }
$operator = if ($Force) {'&'} else {'&&'}

# Record environment variables before running the batch script
$envBefore = @{}
foreach ($_ in cmd /c "SET")
{
    if ($_ -match '^([^=]+)=(.*)')
    {
        $envBefore.Add($matches[1], $matches[2])
    }
}

# Run the script and call SET afterwards to get new environment which we can then diff
$envAfter = @{}
foreach($_ in cmd /c " $Command > `"$stream`" 2>&1 $operator SET")
{
    if ($_ -match '^([^=]+)=(.*)')
    {
        $envAfter.Add($matches[1], $matches[2])
    }
}

# Diff the environment before and after running the script
foreach ($name in $envBefore.Keys)
{
    if (-not $envAfter.ContainsKey($name))
    {
        # Environment variable has been removed by script
        # Write-Host "REMOVED $name"
        [System.Environment]::SetEnvironmentVariable($name, $null)
    }
}
foreach ($name in $envAfter.Keys)
{
    if ($envBefore.ContainsKey($name))
    {
        if ($envBefore[$name] -cne $envAfter[$name])
        {
            # Environment variable has been changed by script
            # Write-Host ("CHANGED $name = " + $envAfter[$name])
            [System.Environment]::SetEnvironmentVariable($name, $envAfter[$name])
        }
    }
    else
    {
        # Environment variable has been added by script
        # Write-Host ("ADDED $name = " + $envAfter[$name])
        [System.Environment]::SetEnvironmentVariable($name, $envAfter[$name])
    }
}

# Clean up
if ($Output)
{
    Get-Content -LiteralPath $temp
    Remove-Item -LiteralPath $temp
}
}
