function Net-Use
{
    param
    (
        [Parameter(Mandatory=$true)][string]$Drive,
        [Parameter(Mandatory=$true)][string]$Path
    )
    net use "$Drive`:" $Path /user:corpdom\cruise Crui5e
}
