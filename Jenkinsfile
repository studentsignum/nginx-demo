pipeline {
    agent any
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/studentsignum/nginx-demo.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Stop all running Docker containers
                    sh 'docker stop $(docker ps -q) || true'
                    
                    // Build Docker image
                    sh 'docker build . -t nginx-demo'
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh 'docker run -d -p 123:80 nginx-demo'
                }
            }
        }
    }
}