pipeline {
    agent { label 'my-terraform-agent' }
        stage('Clone repository') {
            steps {
                git url: 'https://github.com/BhairaviSanskriti/Test-Jenkins.git'
            }
        }
        
        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
                
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
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
