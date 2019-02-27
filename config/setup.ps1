# Setup symbolic links
mklink $home\.gitconfig (Join-Path $PSScriptRoot .gitconfig)
mklink $home\AppData\Roaming\Code\User\settings.json (Join-Path $PSScriptRoot vscode.json)
mklink $home\AppData\Roaming\Code\User\keybindings.json (Join-Path $PSScriptRoot vscode.keybindings.json)
