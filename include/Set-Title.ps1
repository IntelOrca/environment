function Set-Title
{
    param
    (
        [Parameter(Mandatory=1)][string]$Title
    )
    $host.ui.RawUI.WindowTitle = $Title
}
