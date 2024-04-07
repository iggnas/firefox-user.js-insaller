function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) }

$ProfilePath = (Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" | Where-Object { $_.Name -like "*default-release*" }).FullName

if ($ProfilePath) {
    Write-Host "Firefox profile directory found."
} else {
    Write-Host "Firefox profile directory was not found."
}

$UserJsFiles = @{
    '1' = @{ 'url' = 'https://raw.githubusercontent.com/iggnas/firefox-user.js-insaller/main/user.js'; 'outputFile' = "$ProfilePath\user.js" }
    '2' = @{ 'url' = 'https://raw.githubusercontent.com/arkenfox/user.js/master/user.js'; 'outputFile' = "$ProfilePath\user.js" }
    '3' = @{ 'url' = 'https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js'; 'outputFile' = "$ProfilePath\user.js" }
    '4' = @{ 'url' = 'https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js'; 'outputFile' = "$ProfilePath\user.js" }
    '5' = @{ 'url' = 'https://raw.githubusercontent.com/iggnas/firefox-user.js-insaller/main/NarsilFork.js'; 'outputFile' = "$ProfilePath\user.js" }
}

function DownloadUserJs($url, $outputFile) {
    try {
        Invoke-WebRequest $url -OutFile $outputFile
        Write-Host "Installation completed successfully"
    } catch {
        Write-Host "An error occurred during installation: $_.Exception.Message"
    }
}

$MainMenu = {
    Clear-Host
    Write-HostCenter '______________ Firefox user.js Installer ______________'
    Write-HostCenter '______________________ by iggnas ______________________'
    Write-Host "`n`n"
    Write-HostCenter "[1] Install Narsil user.js        [2] Install Arkenfox user.js"
	Write-Host "`n"
    Write-HostCenter "[3] Install Betterfox user.js     [4] Install pyllyukko user.js"
	Write-Host "`n"
    Write-HostCenter "[5] Install my fork of Narsil user.js"
}

while ($true) {
    &$MainMenu
    Write-Host "`n"
    $Selection = Read-Host "Make a selection"
    
    if ($UserJsFiles.ContainsKey($Selection)) {
        $userJs = $UserJsFiles[$Selection]
		Write-Host "`n"
        Write-Host "Installing $($userJs.url)"
        Start-Sleep -Seconds 1
        DownloadUserJs $userJs.url $userJs.outputFile
    } else {
        Write-Host "Invalid selection. Please choose a valid option."
    }
}
