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

## 2. Powershell script to Install SSMS
```bash
# Define download URL and temporary path
$Url = "https://aka.ms/ssmsfullsetup"
$Path = "$env:TEMP\SSMS-Setup.exe"

# 1. Ensure TLS 1.2 is used for the download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 2. Download the latest SSMS installer
Write-Host "Downloading SSMS Installer (this may take a few minutes)..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $Url -OutFile $Path

# 3. Run the installer silently
# /Install = Start installation
# /Passive = Show progress bar but no user interaction
# /NoRestart = Don't force a reboot immediately
Write-Host "Installing SSMS..." -ForegroundColor Cyan
Start-Process -FilePath $Path -ArgumentList "/Install", "/Passive", "/NoRestart" -Wait

# 4. Cleanup
Remove-Item -Path $Path
Write-Host "SSMS Installation Complete! Please restart your VM to finalize." -ForegroundColor Green
```
