winget source update

Write-Output "Instalando Paquetes Chocolatey"
# Comentar para omitir
$AppsCT = @(
    "font-awesome-font"
    "filezilla"
    "nerd-fonts-jetbrainsmono"
)

ForEach ($App in $AppsCT) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    choco install $App -y
}

# Comentar para omitir
$AppsWG = @(
    "Microsoft Visual Studio Code"
    "Mozilla.Firefox"
    "Microsoft PowerToys"
    "Git.Git"
    "GitHub Desktop"
    "Python.Python.3.13"
    "Amazon.Corretto.17.JDK"
    "Brave.Brave"
    "Google.Chrome"
    "VLC media player"
    "mpv.net"
    "WinSCP"
    "Glary Utilities"
    "calibre"
    "TheDocumentFoundation.LibreOffice"
    "SumatraPDF"
    "Core Temp"
    "WinRAR"
    "Microsoft.WindowsTerminal"
    "Microsoft.PowerShell"
    "JanDeDobbeleer.OhMyPosh"
    "Microsoft.PowerBI"
    "Microsoft.SQLServerManagementStudio"
)

Write-Output "Instalando Paquetes con Winget"

ForEach ($App in $AppsWG) {
    $App = $App.TrimEnd()
    Write-Output "Instalando $App"
    winget install $App --silent --accept-package-agreements
}

# SQL Server
winget install "Microsoft.SQLServer.2022.Developer" --override "/ENU"

Stop-Process -Name "brave" -ErrorAction SilentlyContinue

$SN = Read-Host -Prompt "Se recomienda reiniciar el equipo, desea hacerlo ahora? (S/N): "
if ( $SN -eq "S" ) {
    Restart-Computer
}