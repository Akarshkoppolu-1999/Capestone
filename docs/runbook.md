# Deployment Runbook

## Automated Deployment
The deployment is triggered automatically by GitHub Actions when code is pushed to the `main` branch.

## Manual Deployment (Staging)
If you need to deploy manually:
1. SSH into the server.
2. Navigate to the project directory.
3. Run the deployment script:
   ```bash
   bash scripts/deploy.sh
   ```

## Verification Steps
1. Check container status: `docker ps`.
2. Check logs: `docker-compose logs -f`.
3. Verify API health: `curl http://localhost:8081/api/health`.
