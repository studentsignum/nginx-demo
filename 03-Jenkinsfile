// Jenkinsfile

pipeline {
  agent any

  stages {
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("nginx-app:${env.BUILD_NUMBER}")
        }
      }
    }
    
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://registry.example.com', 'docker-registry-credentials') {
            docker.image("nginx-app:${env.BUILD_NUMBER}").push()
          }
        }
      }
    }
    
    stage('Deploy to GCP') {
      steps {
        sh 'gcloud compute scp --recurse hello.txt docker-host:/var/www/'
        sh 'gcloud compute ssh docker-host --command "docker run -d -p 80:80 nginx-app:${env.BUILD_NUMBER}"'
      }
    }
  }
}
