# Jenkins Setup Guide

If you prefer using Jenkins over GitHub Actions, follow these steps:

## 1. Prerequisites
- **Jenkins** installed and running.
- **Plugins**: Docker, Pipeline, Git, and potentially Blue Ocean for a better UI.
- **Trivy** installed on the Jenkins agent machine.

## 2. Credentials
1. Go to `Manage Jenkins > Credentials`.
2. Add a new credential of type **Username with password**.
3. ID: `docker-hub-credentials`.
4. Username: Your Docker Hub username.
5. Password: Your Docker Hub Personal Access Token.

## 3. Create the Pipeline
1. Create a "New Item" in Jenkins.
2. Select **Pipeline**.
3. Under "Pipeline", select **Pipeline script from SCM**.
4. SCM: **Git**.
5. Repository URL: Your GitHub repository URL.
6. Script Path: `Jenkinsfile`.

## 4. How to show the "Staging Build"
The "Staging" part of your project happens in the last stage of Jenkins. Here is what you show your trainer:

1.  **Stage View**: Point at the green box labeled **"Deploy to Staging"**.
2.  **Console Output**: Click on the "Deploy to Staging" stage and show the logs. It will show:
    -   `docker-compose pull` (Getting the new code).
    -   `docker-compose up -d` (Starting the staging environment).
    -   `Verifying deployment... Deployment Successful!` (This proves staging is working).
3.  **The Result**: Open `http://localhost:8081` and show the "Status: Online" message. Explain that this is your **Staging Environment**.
