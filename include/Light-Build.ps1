function Light-Build
{
    msbuild /nologo /v:q /p:BuildProjectReferences=false $args
}

Set-Alias lightbuild Light-Build
Set-Alias lb Light-Build
