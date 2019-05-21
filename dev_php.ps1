# Description: Boxstarter Script
# Author: Microsoft
# Common settings for web development with NodeJS

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

$webClient = (New-Object System.Net.WebClient)
$objShell = New-Object -ComObject Shell.Application

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "HyperV.ps1";
executeScript "Docker.ps1";
executeScript "WSL.ps1";
executeScript "Browsers.ps1";

#--- Not related to development ---
choco install -y vlc
choco install -y FoxitReader
choco install -y spotify

#--- VSCode Extensions ---
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension felixfbecker.php-debug
code --install-extension neilbrayfield.php-docblocker
code --install-extension kokororin.vscode-phpfmt
code --install-extension Yish.php-snippets-for-vscode
code --install-extension marabesi.php-import-checker
code --install-extension sevavietl.php-files
code --install-extension octref.vetur
code --install-extension isudox.vscode-jetbrains-keybindings
code --install-extension SolarLiner.linux-themes
code --install-extension cjhowe7.laravel-blade
code --install-extension amiralizadeh9480.laravel-extra-intellisense

#--- Tools ---
choco install -y nodejs-lts # Node.js LTS, Recommended for most users
choco install -y yarn
# choco install -y visualstudio2017buildtools
# choco install -y visualstudio2017-workload-vctools
choco install -y python2 # Node.js requires Python 2 to build native modules
choco install -y notepadplusplus
choco install -y putty
choco install -y cmder
choco install -y insomnia-rest-api-client 
choco install -y firacode
choco install -y hackfont
choco isntall -y php
choco install -y composer
choco install -y phpstorm
choco install -y datagrip
choco install -y microsoftwebdriver

#--- Fonts ---
$objFolder = $objShell.Namespace(0x14)

$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Bold.ttf", "C:\dev\fonts\FiraCodeiScript-Bold.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Regular.ttf", "C:\dev\fonts\FiraCodeiScript-Regular.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Italic.ttf", "C:\dev\fonts\FiraCodeiScript-Italic.ttf")

foreach($File in $(Ls "C:\dev\fonts")) {
    $objFolder.CopyHere($File.fullname)
}

#--- Lando ---
$webClient.DownloadFile("https://github.com/lando/lando/releases/download/v3.0.0-rc.16/lando-v3.0.0-rc.16.exe", "C:\dev\lando.exe")
C:\dev\lando.exe /S /q



Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
