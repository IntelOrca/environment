function linkup
{
    param([String]$src, [String]$dst)

    cmd /c "if exist ""$src"" (del ""$src"")"
    mklink $src $dst
}

# Setup symbolic links
linkup $home\.gitconfig (Join-Path $PSScriptRoot .gitconfig)
linkup $home\AppData\Roaming\Code\User\settings.json (Join-Path $PSScriptRoot vscode.json)
linkup $home\AppData\Roaming\Code\User\keybindings.json (Join-Path $PSScriptRoot vscode.keybindings.json)
