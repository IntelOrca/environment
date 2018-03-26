function exp
{
    devenv /nosplash /rootsuffix exp $args
}

function lightbuild
{
    msbuild /nologo /v:q /p:BuildProjectReferences=false $args
}

function testenv
{
    call "$env:MFSOLAR_ROOT\cobdir\Debug\x86\CreateTestEnv.bat"
}
