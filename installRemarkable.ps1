# This script downloads and installs the reMarkable software silently.
# It performs the following steps:
# 1. Defines variables for the download URL, destination path, and installation arguments.
# 2. Downloads the reMarkable installer from the specified URL.
# 3. Starts the installation process with silent and no-restart options.
# 4. Checks the exit code of the installation process to determine success or failure.
# 5. Cleans up by removing the installer file after installation.

# Variables
$downloadUrl = "https://downloads.remarkable.com/latest/windows"
$destinationPath = "$env:TEMP\reMarkableInstaller.exe"
$arguments = "/silent /norestart"

# Download remarkable installer
Write-Host "Downloading reMarkable installer from $downloadUrl" -ForegroundColor Cyan
try
{
    (New-Object Net.WebClient).DownloadFile($downloadUrl, $destinationPath)
  Write-Host "Download completed successfully." -ForegroundColor Green
} catch
{
  Write-Host "Download failed! Try again next time." -ForegroundColor Red
  Exit 1
}

# Start the installation process
Write-Host "Starting the installation of reMarkable..." -ForegroundColor Green
$process = Start-Process -FilePath $destinationPath -ArgumentList $arguments -PassThru -Wait
$exitCode = $process.ExitCode

if ($exitCode -eq 0)
{
  Write-Host "Installation completed successfully." -ForegroundColor Green
} else
{
  Write-Host "Installation failed with exit code: $exitCode" -ForegroundColor Red
}

# Cleanup 
if (Test-Path $destinationPath)
{
  Remove-Item $destinationPath -Force
  Write-Host "Installer file has been removed." -ForegroundColor Yellow
}
