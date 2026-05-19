## 1. Powershell script Chrome in Windows VM
```bash
# Force the session to use TLS 1.2 (Required for many modern secure downloads)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Define clean, direct URLs for the standalone installer
$ChromeInstallerUrl = "https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe"
$DownloadPath = "$env:TEMP\ChromeStandaloneSetup64.exe"

# Step 1: Download the Chrome standalone installer
Write-Host "Downloading Google Chrome..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $ChromeInstallerUrl -OutFile $DownloadPath -UseBasicParsing
    Write-Host "Download complete." -ForegroundColor Green
} catch {
    Write-Error "Failed to download Chrome. Error: $_"
    return
}

# Step 2: Install Chrome silently
Write-Host "Installing Google Chrome silently..." -ForegroundColor Cyan

# /silent /install are the native switches for Chrome's standalone EXE
$Process = Start-Process -FilePath $DownloadPath -ArgumentList '/silent', '/install' -Wait -PassThru

# Step 3: Verify and cleanup
if ($Process.ExitCode -eq 0 -or $Process.ExitCode -eq $null) {
    Write-Host "Google Chrome installed successfully!" -ForegroundColor Green
    # Clean up the installer
    Remove-Item -Path $DownloadPath -Force
} else {
    Write-Warning "Installation finished, but returned exit code: $($Process.ExitCode)"
}
```
