pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // Jenkins Credentials ID for Docker Hub
        GIT_CREDENTIALS_ID = 'github-credentials'         // Jenkins Credentials ID for GitHub
        K8S_CREDENTIALS_ID = 'kubernetes-config'         // Jenkins Secret for Kubernetes Config
        DOCKER_IMAGE_FRONTEND = 'your-dockerhub-username/pipelinecraft-frontend'
        DOCKER_IMAGE_BACKEND = 'your-dockerhub-username/pipelinecraft-backend'
        KUBE_NAMESPACE = 'pipelinecraft'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM', 
                        branches: [[name: '*/main']], 
                        userRemoteConfigs: [[
                            credentialsId: GIT_CREDENTIALS_ID, 
                            url: 'https://github.com/Lavanya45678/pipelinecraft-app.git'
                        ]]
                    ])
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_FRONTEND}:latest", "-f infrastructure/docker/frontend.Dockerfile .")
                    docker.build("${DOCKER_IMAGE_BACKEND}:latest", "-f infrastructure/docker/backend.Dockerfile .")
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            docker login -u $DOCKER_USER -p $DOCKER_PASS
                            docker push ${DOCKER_IMAGE_FRONTEND}:latest
                            docker push ${DOCKER_IMAGE_BACKEND}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: K8S_CREDENTIALS_ID]) {
                        sh """
                            kubectl apply -f infrastructure/kubernetes/frontend-deployment.yaml -n ${KUBE_NAMESPACE}
                            kubectl apply -f infrastructure/kubernetes/backend-deployment.yaml -n ${KUBE_NAMESPACE}
                        """
                    }
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh "kubectl get pods -n ${KUBE_NAMESPACE}"
                    sh "kubectl get svc -n ${KUBE_NAMESPACE}"
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Deployment Failed!"
        }
        success {
            echo "✅ Deployment Successful!"
        }
    }
}
