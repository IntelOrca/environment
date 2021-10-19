function Setup-VSPrompt
{
    param
    (
        [ValidateSet('x86','amd64','arm', 'arm64')]
        [string]$Architecture
    )

    # Find VS
    $years = @("2022", "2019", "2017")
    $skus = @("Enterprise", "Professional", "Community", "Preview", "BuildTools")
    $basePath32 = "C:\Program Files (x86)\Microsoft Visual Studio"
    $basePath64 = "C:\Program Files\Microsoft Visual Studio"
    foreach ($year in $years)
    {
        $basePath = $basePath64
        if ($year -eq "2017" -or $year -eq "2019")
        {
            $basePath = $basePath32
        }
        foreach ($sku in $skus)
        {
            $potentialPath = "$basePath\$year\$sku"
            if (Test-Path $potentialPath)
            {
                $foundPath = $potentialPath
                break
            }
        }
    }

    if (-not $foundPath)
    {
        throw "VS 2017 could not be found"
    }

    $command = """$foundPath\Common7\Tools\VsDevCmd.bat"""
    if ($Architecture)
    {
        $command += " -arch=$Architecture"
    }
    Call-Batch -Command $command
}

Set-Alias vsdevcmd Setup-VSPrompt
