## 1. Powershell script Chrome in Windows VM
```bash
# Define the path for the installer
$Path = "$env:TEMP\ChromeInstaller.exe"

# Download the latest Chrome installer
Write-Host "Downloading Chrome..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path

# Run the installer silently
Write-Host "Installing Chrome..." -ForegroundColor Cyan
Start-Process -FilePath $Path -ArgumentList "/silent", "/install" -Wait

# Clean up the installer file
Remove-Item -Path $Path
Write-Host "Installation Complete!" -ForegroundColor Green
```
