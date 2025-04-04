# Check if winget is available
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "winget is available. Proceeding with installation."

    # Install OBS Studio using winget
    Write-Host "Installing OBS Studio..."
    winget install -e --id OBSProject.OBSStudio

    Write-Host "OBS Studio installation is complete."
} else {
    Write-Host "winget is not installed. Please install Windows Package Manager first."
}
