#!/bin/bash

# Configuration
PROJECT_NAME="capstone-staging"
DOCKER_USERNAME="akarshkoppolu14"

echo "Starting Deployment for Staging..."

# 1. Stop old containers (if any) and start new ones
echo "Restarting services..."
# We use -p to ensure a consistent project name regardless of the folder name
docker-compose -p ${PROJECT_NAME} down
docker-compose -p ${PROJECT_NAME} up -d

# 2. Verify deployment
echo "Verifying deployment..."
# We use 'docker exec' to check health from INSIDE the backend container.
# This works even if Jenkins cannot reach the host's localhost:8081.
RETRIES=10
while [ $RETRIES -gt 0 ]; do
    # Check if backend is alive via Python's internal libraries (no curl needed)
    if docker exec ${PROJECT_NAME}-backend-1 python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/api/health')" > /dev/null 2>&1; then
        echo "Deployment Successful! Backend is healthy."
        echo "You can access the frontend at: http://localhost:8081"
        exit 0
    fi
    echo "Waiting for backend... ($RETRIES retries left)"
    sleep 5
    RETRIES=$((RETRIES-1))
done

echo "Deployment Failed: Backend not responding inside container ${PROJECT_NAME}-backend-1"
echo "Check logs with: docker logs ${PROJECT_NAME}-backend-1"
exit 1
