# Prompt for DockerHub login
Write-Host "🔐 Logging in to DockerHub..."
docker login
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Docker login failed. Exiting script."
    exit 1
}

# Define image name and tag
$imageName = "manchalsharma08/my-applicationnew"
$tag = "v4"
$fullImageName = "${imageName}:${tag}"

# Build Docker image
Write-Host "🔨 Building Docker image: $fullImageName"
docker build -t $fullImageName .

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Docker build failed. Exiting script."
    exit 1
}

# List Docker images
Write-Host "📦 Listing local Docker images..."
docker images

# Push Docker image to DockerHub
Write-Host "📤 Pushing image to DockerHub: $fullImageName"
docker push $fullImageName

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Docker push failed. Exiting script."
    exit 1
}

# Run Docker container
Write-Host "🚀 Running container on port 8088 -> 80"
docker run -d -p 8088:80 $fullImageName

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Container started successfully!"
    Write-Host "🌐 Visit: http://localhost:8088"
} else {
    Write-Error "❌ Failed to run Docker container."
}
