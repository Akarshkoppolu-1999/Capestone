#!/bin/bash

# Configuration
PROJECT_NAME="capstone"
DOCKER_USERNAME="your-dockerhub-username" # This would be an arg in reality

echo "Starting Deployment for Staging..."

# 1. Pull latest images
echo "Pulling latest images..."
docker-compose pull

# 2. Stop old containers and start new ones
echo "Restarting services..."
docker-compose up -d

# 3. Verify deployment
echo "Verifying deployment..."
# Wait for backend to be ready
RETRIES=5
while [ $RETRIES -gt 0 ]; do
    if curl -s http://localhost:8080/api/health | grep "healthy"; then
        echo "Deployment Successful!"
        exit 0
    fi
    echo "Waiting for backend... ($RETRIES retries left)"
    sleep 5
    RETRIES=$((RETRIES-1))
done

echo "Deployment Failed: Backend not responding"
exit 1
