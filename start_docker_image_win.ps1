# Set variables
param (
    [Parameter(Mandatory=$true)]
    [string]$DATA_DIR
)

if (-not (Test-Path $DATA_DIR)) {
    Write-Error "The specified data directory does not exist."
    exit 1
}

$DATA_ZIP_URL = "https://raw.githubusercontent.com/morph-l2/config-template/main/holesky/data.zip"
$DOCKER_COMPOSE_FILE = "docker-compose.yml"

# Ensure necessary utilities are installed
$requiredUtilities = @("docker", "unzip", "openssl", "dos2unix")
foreach ($utility in $requiredUtilities) {
    if (-not (Get-Command $utility -ErrorAction SilentlyContinue)) {
        Write-Error "Required utility $utility is not installed."
        exit
    }
}

# Change to the directory containing the docker-compose.yml file
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $SCRIPT_DIR

# Remove the old data directory
if (Test-Path $DATA_DIR) {
    Write-Host "Removing old data directory: $DATA_DIR"
    Remove-Item -Recurse -Force $DATA_DIR
}

# Create a new data directory
Write-Host "Creating new data directory: $DATA_DIR"
New-Item -ItemType Directory -Path $DATA_DIR | Out-Null

# Download and extract data
Set-Location $DATA_DIR
Write-Host "Downloading data file: $DATA_ZIP_URL"
$downloadPath = Join-Path $DATA_DIR "data.zip"
Invoke-WebRequest -Uri $DATA_ZIP_URL -OutFile $downloadPath -ErrorAction Stop

Write-Host "Extracting data file"
Expand-Archive -Path "data.zip" -DestinationPath $DATA_DIR -ErrorAction Stop
openssl.exe rand -hex 32 | Out-File (Join-Path $DATA_DIR "jwt-secret.txt")
dos2unix.exe (Join-Path $DATA_DIR "jwt-secret.txt")

# Return to script directory
Set-Location $SCRIPT_DIR

# Pull and run Docker image
docker pull crazywty/morph-docker-morph:latest -ErrorAction Stop
docker run -d --name morph `
  -v "${DATA_DIR}:/data" `
  -p 8545:8545 `
  -p 8551:8551 `
  -p 26658:26658 `
  -p 26657:26657 `
  -p 26656:26656 `
  -p 26660:26660 `
  -e TZ=UTC `
  crazywty/morph-docker-morph -ErrorAction Stop

