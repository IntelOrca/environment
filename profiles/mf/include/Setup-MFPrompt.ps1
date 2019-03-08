function Setup-MFPrompt
{
    param
    (
        [ValidateSet('64')]
        [string]$Architecture
    )

    # Find MF
    $skus = @("Enterprise Developer", "Visual COBOL")
    $basePath = "C:\Program Files (x86)\Micro Focus"
    foreach ($sku in $skus)
    {
        $potentialPath = "$basePath\$sku"
        if (Test-Path $potentialPath)
        {
            $foundPath = $potentialPath
            break
        }
    }

    if (-not $foundPath)
    {
        throw "MF could not be found"
    }

    $command = """$foundPath\createenv.bat"""
    if ($Architecture)
    {
        $command += " $Architecture"
    }
    Call-Batch -Command $command
}

Set-Alias mfdevcmd Setup-MFPrompt
