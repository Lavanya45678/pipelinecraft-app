pipeline {
    agent any

    environment {
        REGISTRY = "localhost:5000"  // Use Minikube or Local Docker Registry
        FRONTEND_IMAGE = "frontend-app:latest"
        BACKEND_IMAGE = "backend-app:latest"
        KUBE_CONFIG = "$HOME/.kube/config"
    }

    stage('Checkout Code') {
    steps {
        git branch: 'main', credentialsId: 'Lavanya45678-pat', url: 'https://github.com/Lavanya45678/pipelinecraft-app.git'
    }
}



        stage('Build Frontend Image') {
            steps {
                script {
                    sh 'docker build -t $REGISTRY/$FRONTEND_IMAGE -f infrastructure/docker/frontend.Dockerfile .'
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    sh 'docker build -t $REGISTRY/$BACKEND_IMAGE -f infrastructure/docker/backend.Dockerfile .'
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    sh 'docker push $REGISTRY/$FRONTEND_IMAGE'
                    sh 'docker push $REGISTRY/$BACKEND_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f infrastructure/kubernetes/backend-deployment.yaml'
                    sh 'kubectl apply -f infrastructure/kubernetes/frontend-deployment.yaml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh 'kubectl get pods'
                    sh 'kubectl get svc'
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
