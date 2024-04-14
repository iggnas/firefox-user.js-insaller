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
	'6' = @{ 'url' = 'https://raw.githubusercontent.com/HardwareGeiler/Betterfox/main/user.js'; 'outputFile' = "$ProfilePath\user.js" }
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
	Write-Host "`n`n`n`n`n"
	Write-Host "[1] Install Narsil"
	Write-Host "`n"
	Write-Host "[2] Install Arkenfox"
	Write-Host "`n"
	Write-Host "[3] Install Betterfox"
	Write-Host "`n"
	Write-Host "[4] Install pyllyukko"
	Write-Host "`n"
	Write-Host "[5] Install my fork of Narsil"
	Write-Host "`n"
	Write-Host "[6] Install HardwareGeiler fork of Betterfox"
}

while ($true) {
    &$MainMenu
    Write-Host "`n`n`n"
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
