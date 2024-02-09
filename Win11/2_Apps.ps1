Write-Output "Instalando Chocolatey"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Instalando Paquetes"
# Comentar para omitir
$AppsCT = @(
    "mpv"
    "filezilla"
    "shellcheck"
    "ripgrep"
    "fd"
    "nerd-fonts-jetbrainsmono"
    "llvm"
    "vmware-workstation-player"
)

ForEach ($App in $AppsCT) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}

Write-Output "Instalando WinGet..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

# Comentar para omitir
$AppsWG = @(
    "Microsoft Visual Studio Code"
    "Mozilla.Firefox"
    "Microsoft PowerToys"
    "Git.Git"
    "GitHub Desktop"
    "Python.Python.3.12"
    "GoLang.Go"
    "Amazon.Corretto.17"
    "Amazon.Corretto.21"
    "Brave.Brave"
    "Google Chrome"
    "qBittorrent.qBittorrent"
    "VLC media player"
    "WinSCP"
    "Glary Utilities"
    "calibre"
    "TheDocumentFoundation.LibreOffice"
    "SumatraPDF"
    "Neovim"
    "Helix.Helix"
    "balenaEtcher"
    "HandBrake"
    "Core Temp"
    "Node.js"
    "Yarn.Yarn"
    "GoLang.Go"
    "WinRAR"
    "Meson Build System"
    #"Apple.iTunes"
    "Microsoft.PowerShell"
    "JanDeDobbeleer.OhMyPosh"
    #"Microsoft.PowerBI"
    #"Tableau.Public"
    "Rainmeter"
    "Microsoft.SQLServerManagementStudio"
    "OO-Software.ShutUp10"
    "Flameshot"
    "pgAdmin 4"
)

winget source update

Write-Output "Instalando Paquetes con Winget"

ForEach ($App in $AppsWG) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    winget install $App --silent --accept-package-agreements
}

winget install "Microsoft.VisualStudio.2022.Community" --override "--passive --config $PSScriptRoot\my.vsconfig"
winget install "PostgreSQL 16" --silent --accept-package-agreements
winget install "Oracle.MySQL" --silent --accept-package-agreements

# Limpieza Escritorio
Get-ChildItem -Path $HOME\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }
Get-ChildItem -Path C:\Users\Public\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }

# Orden iconos escritorio
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" -Name FFlags -Value "1075839525"

# Taskbar
Move-Item -Path "$PSScriptRoot\LayoutModification.xml" -Destination "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"
((Get-Content -path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml -Raw) -replace 'Usuario', $env:UserName) | Set-Content -Path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml

# Rust
Invoke-WebRequest -Uri https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe -OutFile rustup-init.exe
Invoke-Expression ".\rustup-init.exe -y"

$SN = Read-Host -Prompt "Se recomienda reiniciar el equipo, desea hacerlo ahora? (S/N): "
if ( $SN -eq "S" ) {
    Restart-Computer
}