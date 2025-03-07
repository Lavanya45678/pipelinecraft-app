pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'lavanya111'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials'
        KUBE_CONFIG_CREDENTIALS_ID = 'kube-config'
        BACKEND_IMAGE = "lavanya111/pipelinecraft-backend:latest"
        FRONTEND_IMAGE = "lavanya111/pipelinecraft-frontend:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git credentialsId: "${GIT_CREDENTIALS_ID}", url: 'https://github.com/Lavanya45678/pipelinecraft-app.git', branch: 'main'
                }
            }
        }

        stage('Build and Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def backendImage = docker.build("${BACKEND_IMAGE}", "-f infrastructure/docker/backend.Dockerfile .")
                        def frontendImage = docker.build("${FRONTEND_IMAGE}", "-f infrastructure/docker/frontend.Dockerfile .")

                        backendImage.push('latest')
                        frontendImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: "${KUBE_CONFIG_CREDENTIALS_ID}"]) {
                        sh 'kubectl apply -f infrastructure/kubernetes/backend-deployment.yaml'
                        sh 'kubectl apply -f infrastructure/kubernetes/frontend-deployment.yaml'
                        sh 'kubectl apply -f infrastructure/kubernetes/backend-service.yaml'
                        sh 'kubectl apply -f infrastructure/kubernetes/frontend-service.yaml'
                    }
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh 'kubectl get pods -n default'
                    sh 'kubectl get svc -n default'
                }
            }
        }
    }
}
