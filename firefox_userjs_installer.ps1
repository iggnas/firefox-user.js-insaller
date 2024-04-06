$ProfilePath = (Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" | Where-Object { $_.Name -like "*default-release*" }).FullName

if ($ProfilePath) {
    Write-Host "Firefox profile directory found."
} else {
    Write-Host "The default Firefox profile directory was not found."
}

$MainMenu = {
     Write-Host "_______________ Firefox user.js Installer _______________"
     Write-Host "_______________________ by iggnas _______________________"
     Write-Host ""
     Write-Host ""
     Write-Host ""
     Write-Host "1. Install Narsil user.js"
     Write-Host "2. Install Arkenfox user.js"
     Write-Host "3. Install Betterfox user.js"
     Write-Host "4. Quit"
}

Do {
    cls
    Invoke-Command $MainMenu
    $Selection = Read-Host "Make a selection: "
    Switch ($Selection) {
        '1' {
            Write-Host "Installing Narsil user.js"
			Start-Sleep -Seconds 1
            Invoke-WebRequest "https://raw.githubusercontent.com/iggnas/firefox-user.js-insaller/main/user.js" -OutFile "$ProfilePath\user.js"
        }
        '2' {
            Write-Host "Installing Arkenfox user.js"
			Start-Sleep -Seconds 1
            Invoke-WebRequest "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" -OutFile "$ProfilePath\user.js"
        }
        '3' {
            Write-Host "Installing Betterfox user.js"
			Start-Sleep -Seconds 1
            Invoke-WebRequest "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js" -OutFile "$ProfilePath\user.js"
        }
    }
} while ($Selection -ne '4')
