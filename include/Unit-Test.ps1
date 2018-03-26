function Unit-Test
{
    param([Parameter(Mandatory=$true)][String] $Assembly)

    start cmd -ArgumentList "/c testenv && start nunit-x86 ""$Assembly"""
}
