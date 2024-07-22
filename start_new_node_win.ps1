# Set variables
# Data directory on drive J
$DATA_DIR = "J:\data"
$DATA_ZIP_URL = "https://raw.githubusercontent.com/morph-l2/config-template/main/holesky/data.zip"
$DOCKER_COMPOSE_FILE = "docker-compose.yml"

# Change to the directory containing the docker-compose.yml file
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $SCRIPT_DIR
echo  $SCRIPT_DIR
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
echo $DATA_DIR
Write-Host "Downloading data file: $DATA_ZIP_URL"
wget $DATA_ZIP_URL -OutFile "data.zip"

Write-Host "Extracting data file"
unzip data.zip
openssl.exe rand -hex 32 | Out-File jwt-secret.txt
dos2unix.exe .\jwt-secret.txt
Set-Location $SCRIPT_DIR

# Build Docker images
Write-Host "Building Docker images"
docker-compose -f $DOCKER_COMPOSE_FILE build

# Start Docker containers
Write-Host "Starting Docker containers"
docker-compose -f $DOCKER_COMPOSE_FILE up -d --remove-orphans

# View Docker container logs and keep the script running
Write-Host "Viewing Docker container logs"
docker-compose -f $DOCKER_COMPOSE_FILE logs -f

Write-Host "All steps completed. The service is running in the background."
