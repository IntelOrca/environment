function Unit-Test
{
    param([Parameter(Mandatory=$true)][String] $Assembly)
    powershell -Command 'testenv > $null; nunit-x86 "$Assembly"'
}
