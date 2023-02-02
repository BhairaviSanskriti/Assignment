pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git credentialsID: 'github', url: 'https://github.com/BhairaviSanskriti/Test-Jenkins.git'
            }
        }
      
        stage('Validate Terraform') {
            steps {
                sh 'terraform init'
                
            }
        }
        stage('Run Terraform') {
            steps {
                sh 'terraform init'
                
            }
        }
        stage('Apply Terraform'){
            steps {
              sh 'terraform apply -auto-approve'
            }
        }
    }
}
