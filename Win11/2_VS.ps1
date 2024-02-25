Write-Output "Instalando WinGet..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

winget source update

winget install "Microsoft.VisualStudio.2022.Community" --override "--passive --config $PSScriptRoot\my.vsconfig"