pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "your-dockerhub-username"
        FRONTEND_IMAGE = "pipelinecraft-frontend"
        BACKEND_IMAGE = "pipelinecraft-backend"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[
                        url: 'https://github.com/Lavanya45678/pipelinecraft-app.git',
                        credentialsId: 'github-pat'
                    ]]
                ])
            }
        }

        stage('Build Frontend Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_REGISTRY/$FRONTEND_IMAGE:latest frontend/'
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_REGISTRY/$BACKEND_IMAGE:latest backend/'
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                        sh 'docker push $DOCKER_REGISTRY/$FRONTEND_IMAGE:latest'
                        sh 'docker push $DOCKER_REGISTRY/$BACKEND_IMAGE:latest'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh 'kubectl get pods'
                    sh 'kubectl get services'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
