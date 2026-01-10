#!/bin/bash

# Configuration
PROJECT_NAME="capstone"
DOCKER_USERNAME="akarshkoppolu14"

echo "Starting Deployment for Staging..."

# 1. Pull latest images (optional for local staging but good practice)
echo "Pulling latest images..."
# docker-compose pull # Commented out as we are using locally built images for this demo

# 2. Stop old containers and start new ones
echo "Restarting services..."
docker-compose down
docker-compose up -d

# 3. Verify deployment
echo "Verifying deployment..."
# Wait for backend to be ready via the frontend proxy
RETRIES=10
while [ $RETRIES -gt 0 ]; do
    if curl -s http://localhost:8081/api/health | grep "healthy"; then
        echo "Deployment Successful!"
        exit 0
    fi
    echo "Waiting for backend... ($RETRIES retries left)"
    sleep 5
    RETRIES=$((RETRIES-1))
done

echo "Deployment Failed: Backend not responding on http://localhost:8081/api/health"
exit 1
