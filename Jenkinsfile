pipeline {
    agent any

    environment {
        // Change these to your actual Docker Hub username
        DOCKER_USER = "your-dockerhub-username"
        IMAGE_NAME_BACKEND = "${DOCKER_USER}/capstone-backend"
        IMAGE_NAME_FRONTEND = "${DOCKER_USER}/capstone-frontend"
        DOCKER_CREDS = credentials('docker-hub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Backend Unit Tests') {
            steps {
                // We run tests inside a Docker container so we don't need Python installed on the Jenkins machine
                sh 'docker run --rm -v ${WORKSPACE}/backend:/app -w /app python:3.9-slim /bin/sh -c "pip install -r requirements.txt && pytest"'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME_BACKEND}:latest ./backend
                    docker build -t ${IMAGE_NAME_FRONTEND}:latest ./frontend
                '''
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                sh '''
                    trivy image --severity CRITICAL,HIGH ${IMAGE_NAME_BACKEND}:latest
                    trivy image --severity CRITICAL,HIGH ${IMAGE_NAME_FRONTEND}:latest
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh '''
                    echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
                    docker push ${IMAGE_NAME_BACKEND}:latest
                    docker push ${IMAGE_NAME_FRONTEND}:latest
                '''
            }
        }

        stage('Deploy to Staging') {
            steps {
                // This runs the deployment script we created
                sh 'bash scripts/deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
