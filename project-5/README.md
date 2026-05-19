## 1. Powershell script Chrome in Windows VM
```bash
$ChromeInstallerUrl = "https://dl.google.com/tag/s/appguid%3D%7B8A291C25-D830-4911-96B8-863680B797B2%7D%26iid%3D%7B8A291C25-D830-4911-96B8-863680B797B2%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26brand%3DGCEB%26installdataindex%3Ddefaultbrowser/update2/installers/ChromeStandaloneSetup64.msi"
$DownloadPath = "$env:TEMP\ChromeStandaloneSetup64.msi"

Write-Host "Downloading Google Chrome installer..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $ChromeInstallerUrl -OutFile $DownloadPath

Write-Host "Installing Google Chrome..." -ForegroundColor Cyan
$InstallArgs = @('/i', "`"$DownloadPath`"", '/qn', '/norestart')
$Process = Start-Process -FilePath "msiexec.exe" -ArgumentList $InstallArgs -Wait -PassThru

if ($Process.ExitCode -eq 0) {
    Write-Host "Google Chrome installed successfully!" -ForegroundColor Green
    # Clean up the installer file
    Remove-Item -Path $DownloadPath -Force
} else {
    Write-Warning "Installation failed with exit code $($Process.ExitCode)."
}
```
