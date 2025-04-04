# Prompt the user for a username
$username = Read-Host "Enter the username for the offline account"

# Define the file path where the accounts.json should be saved
$filePath = [System.IO.Path]::Combine($env:APPDATA, "PrismLauncher", "accounts.json")

# Ensure the directory exists
$directory = [System.IO.Path]::GetDirectoryName($filePath)
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory | Out-Null
}

# Create the account JSON structure
$accountJson = @{
    accounts = @(
        @{
            entitlement = @{
                canPlayMinecraft = $true
                ownsMinecraft = $true
            }
            "msa-client-id" = ""
            type = "MSA"
        }
        @{
            active = $true
            profile = @{
                capes = @()
                id = "e78489c068943a139c5446318c2dd160"  # Use a fixed profile ID or modify this as needed
                name = $username  # Set the profile name to the entered username
                skin = @{
                    id = ""
                    url = ""
                    variant = ""
                }
            }
            type = "Offline"
            ygg = @{
                extra = @{
                    clientToken = "f79711b4a49a4e8290d3a7e32f0e6d4a"
                    userName = $username  # Set the Ygg username to the entered username
                }
                iat = 1743795294
                token = "0"
            }
        }
    )
    formatVersion = 3
}

# Convert the structure to JSON
$jsonContent = $accountJson | ConvertTo-Json -Depth 5

# Write the JSON content to the file
Set-Content -Path $filePath -Value $jsonContent

Write-Host "Account JSON file has been saved to $filePath"
