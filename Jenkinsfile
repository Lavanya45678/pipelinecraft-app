pipeline {
    agent any  // Defines where the pipeline will run

    stages {
        checkout([$class: 'GitSCM', 
    branches: [[name: '*/main']], 
    userRemoteConfigs: [[
        url: 'https://github.com/Lavanya45678/pipelinecraft-app.git',
        credentialsId: 'github-pat'
    ]]
])


        stage('Build Frontend Image') {
            steps {
                script {
                    sh 'docker build -t frontend-image ./frontend'
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    sh 'docker build -t backend-image ./backend'
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    sh 'docker tag frontend-image myrepo/frontend-image:latest'
                    sh 'docker push myrepo/frontend-image:latest'

                    sh 'docker tag backend-image myrepo/backend-image:latest'
                    sh 'docker push myrepo/backend-image:latest'
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
