# Lang Servers & Tools
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest

pip install black 'python-lsp-server[all]' pyright yamllint autopep8

cargo install taplo-cli --locked
cargo install stylua

npm install -g neovim prettier bash-language-server vscode-langservers-extracted emmet-ls typescript typescript-language-server yaml-language-server live-server markdownlint markdownlint-cli dockerfile-language-server-nodejs stylelint js-beautify

Invoke-WebRequest -Uri https://github.com/artempyanykh/marksman/releases/download/2023-12-09/marksman.exe -OutFile marksman.exe 
Move-Item -Path "$PSScriptRoot\marksman.exe" -Destination "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"
