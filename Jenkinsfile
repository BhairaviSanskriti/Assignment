pipeline {
    agent any
    environment{
        BRANCH_NAME='main'
        THE_BUTLER_SAYS_SO=credentials('aws')
    }
    stages{
        stage('Clone repository') {
            steps {
                git branch: env.BRANCH_NAME, changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/BhairaviSanskriti/Test-Jenkins.git'
            }
        }
        
        
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
                
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        sh 'terraform apply -auto-approve tfplan'
                    } else {
                        echo 'Not applying changes, as this is not the master branch.'
                    }
                }
            }
        }
    }
}
