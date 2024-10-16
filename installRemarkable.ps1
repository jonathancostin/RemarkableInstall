# Variables
$downloadUrl = "https://downloads.remarkable.com/latest/windows"
$destinationPath = "$env:TEMP\reMarkableInstaller.exe"
$arguments = "/silent /norestart"

# Download remarkable installer
Write-Host "Downloading reMarkable installer from $downloadUrl" -ForegroundColor Cyan
(New-Object Net.WebClient).DownloadFile("$downloadUrl", "$destinationPath")

# Check if the download was successful
if (Test-Path $destinationPath)
{
  Write-Host "Download completed successfully." -ForegroundColor Green
} else
{
  Write-Host "Download failed! Try again next time." -ForegroundColor Red
  Exit 1
}

# Start the installation process
Write-Host "Starting the installation of reMarkable..." -ForegroundColor Green
$process = Start-Process -FilePath $destinationPath -ArgumentList $arguments -PassThru -Wait
$process.ExitCode

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

