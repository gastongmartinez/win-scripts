Write-Output "Instalando Chocolatey"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Instalando Paquetes"
# Comentar para omitir
$AppsCT = @(
    "jdk8"
    "mpv"
    "filezilla"
    "shellcheck"
    "ripgrep"
    "fd"
    "nerd-fonts-jetbrainsmono"
    "llvm"
)

ForEach ($App in $AppsCT) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}

$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
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
    "Brave.Brave"
    "Google Chrome"
    "qBittorrent.qBittorrent"
    "VLC media player"
    "WinSCP"
    "Glary Utilities"
    "calibre"
    #"Obsidian.Obsidian"
    "TheDocumentFoundation.LibreOffice"
    "SumatraPDF"
    "Neovim"
    "Helix.Helix"
    "balenaEtcher"
    "HandBrake"
    "Core Temp"
    #"Alacritty"
    "Node.js"
    "Yarn.Yarn"
    "GoLang.Go"
    #"Oracle VM VirtualBox"
    "WinRAR"
    "Meson Build System"
    #"PyCharm Professional Edition"
    #"DataGrip"
    #"CLion"
    #"JetBrains Rider"
    #"Apple.iTunes"
    "Microsoft.PowerShell"
    "JanDeDobbeleer.OhMyPosh"
    #"Microsoft.PowerBI"
    #"Tableau.Public"
    "Rainmeter"
    "Microsoft.VisualStudio.2022.Community"
    "Microsoft.SQLServerManagementStudio"
    "OO-Software.ShutUp10"
    "Flameshot"
    "PostgreSQL 16"
    "pgAdmin 4"
    "Oracle.MySQL"
)

winget source update

Write-Output "Instalando Paquetes con Winget"

ForEach ($App in $AppsWG) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    winget install $App --silent --accept-package-agreements
}

# Limpieza Escritorio
Get-ChildItem -Path $HOME\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }
Get-ChildItem -Path C:\Users\Public\Desktop -Include *.lnk -File -Recurse | ForEach-Object { $_.Delete() }

# Orden iconos escritorio
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" -Name FFlags -Value "1075839525"

# Taskbar
Move-Item -Path "$PSScriptRoot\LayoutModification.xml" -Destination "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"   

((Get-Content -path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml -Raw) -replace 'Usuario', $env:UserName) | Set-Content -Path C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml

$SN = Read-Host -Prompt "Se recomienda reiniciar el equipo, desea hacerlo ahora? (S/N): "
if ( $SN -eq "S" ) {
    Restart-Computer
}