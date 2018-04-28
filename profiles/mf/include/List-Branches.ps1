function List-Branches
{
    param([String] $path = $null)

    if ($path -eq $null)
    {
        $path = (Get-Location).Path
    }

    $subDirectories = (Get-ChildItem $path)
    $items = @()
    foreach ($subDirectory in $subDirectories)
    {
        $url = (svn info ($subDirectory.FullName) --show-item url 2> $null)
        if ($url)
        {
            $item = [PSCustomObject]@{
                Name = $subDirectory.Name
                Url = $url
            }
            $items += $item
        }
    }
    $items | Format-Table -auto
}
