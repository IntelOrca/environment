function Setup-VSPrompt
{
    param
    (
        [ValidateSet('x86','amd64','arm', 'arm64')]
        [string]$Architecture
    )

    $command = '"C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"'
    if ($Architecture)
    {
        $command += " -arch=$Architecture"
    }
    Call-Batch -Command $command
}

Set-Alias vsdevcmd Setup-VSPrompt
