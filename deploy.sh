#!/bin/bash

# Deploy script for Shum UI to AWS EC2
set -e

# Configuration
EC2_HOST=${EC2_HOST:-"your-ec2-host"}
EC2_USER=${EC2_USER:-"ubuntu"}
DOCKER_IMAGE="shum-ui:latest"
CONTAINER_NAME="shum-app"

echo "🚀 Starting deployment to EC2..."

# Build Docker image
echo "📦 Building Docker image..."
docker build -t $DOCKER_IMAGE .

# Save image to tar file
echo "💾 Saving Docker image..."
docker save $DOCKER_IMAGE | gzip > shum-ui.tar.gz

# Copy image to EC2
echo "📤 Copying image to EC2..."
scp -i ~/.ssh/your-key.pem shum-ui.tar.gz $EC2_USER@$EC2_HOST:~/

# Deploy on EC2
echo "🔧 Deploying on EC2..."
ssh -i ~/.ssh/your-key.pem $EC2_USER@$EC2_HOST << 'EOF'
    # Load Docker image
    echo "📥 Loading Docker image..."
    docker load < shum-ui.tar.gz
    
    # Stop and remove old container
    echo "🛑 Stopping old container..."
    docker stop shum-app || true
    docker rm shum-app || true
    
    # Run new container
    echo "▶️ Starting new container..."
    docker run -d \
        --name shum-app \
        --restart unless-stopped \
        -p 80:80 \
        shum-ui:latest
    
    # Clean up
    echo "🧹 Cleaning up..."
    rm shum-ui.tar.gz
    docker image prune -f
    
    # Health check
    echo "🏥 Health check..."
    sleep 5
    curl -f http://localhost/health || echo "Health check failed"
    
    echo "✅ Deployment completed!"
EOF

# Clean up local files
rm shum-ui.tar.gz

echo "🎉 Deployment finished!" 