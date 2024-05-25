$ProfilePath = (Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" | Where-Object { $_.Name -like "*default-release*" }).FullName

if ($ProfilePath) {
    Write-Host "Firefox profile directory found."
} else {
	Write-Host "Firefox profile directory was not found."
}

function DownloadUserJs($url, $outputFile) {
    try {
        Invoke-WebRequest $url -OutFile $outputFile
        Write-Host "Installation completed successfully"
    } catch {
        Write-Host "An error occurred during installation: $_.Exception.Message"
    }
}

DownloadUserJs https://raw.githubusercontent.com/iggnas/Betterfox/main/user.js $ProfilePath\user.js