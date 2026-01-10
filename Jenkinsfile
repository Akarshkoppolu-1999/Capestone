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

        stage('Build & Test Backend') {
            steps {
                sh '''
                    # 1. First, build the backend image
                    docker build -t ${IMAGE_NAME_BACKEND}:test ./backend
                    
                    # 2. Run the tests inside the built image
                    docker run --rm ${IMAGE_NAME_BACKEND}:test pytest
                '''
            }
        }

        stage('Build Frontend & Prepare Production') {
            steps {
                sh '''
                    # Build frontend image
                    docker build -t ${IMAGE_NAME_FRONTEND}:latest ./frontend
                    
                    # Tag the verified backend image as latest
                    docker tag ${IMAGE_NAME_BACKEND}:test ${IMAGE_NAME_BACKEND}:latest
                '''
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                sh '''
                    # Using Docker to run Trivy so you don't have to install it on the server
                    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity CRITICAL,HIGH ${IMAGE_NAME_BACKEND}:latest
                    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity CRITICAL,HIGH ${IMAGE_NAME_FRONTEND}:latest
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
