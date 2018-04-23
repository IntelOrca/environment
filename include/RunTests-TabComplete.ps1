function TabExpansion($line, $lastWord)
{
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    if ($lastBlock.StartsWith(".\runtest.bat ", [StringComparison]::OrdinalIgnoreCase))
    {
        RunTestTabExpansion $lastBlock $lastWord $false
    }
    elseif ($lastBlock.StartsWith(".\runtestRepeat.bat ", [StringComparison]::OrdinalIgnoreCase))
    {
        RunTestTabExpansion $lastBlock $lastWord $true
    }
}

function RunTestTabExpansion($line, $currentWord, $isRepeat)
{
    $parts = $line.Split((' '), [System.StringSplitOptions]::RemoveEmptyEntries)
    if ($isRepeat)
    {
        $path = $parts[2]
    }
    else
    {
        $path = $parts[1]
    }
    $lastWord = $parts[-1].ToLower()

    if ($currentWord -ne "")
    {
        $lastWord = $parts[-2].ToLower()
    }

    if ($lastWord -eq "-f")
    {
        $types = (nunitscan $path -p $currentWord)
        if ($LASTEXITCODE -eq 0)
        {
            return $types
        }
    }
    elseif ($lastWord -eq "-c")
    {
        $testFixtureName = $null
        for ($i = 0; $i -lt $parts.Length; $i++)
        {
            if ($parts[$i] -eq "-f")
            {
                if ($i -lt $parts.Length - 1)
                {
                    $testFixtureName = $parts[$i + 1]
                }
                break
            }
        }
        if ($testFixtureName -ne $null)
        {
            $types = (nunitscan $path -f $testFixtureName -p $currentWord)
            if ($LASTEXITCODE -eq 0)
            {
                return $types
            }
        }
        return @()
    }
}
