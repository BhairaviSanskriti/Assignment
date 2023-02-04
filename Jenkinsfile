pipeline {
    agent any
    environment{
        BRANCH_NAME='main'
        THE_BUTLER_SAYS_SO=credentials('aws')
    }
    stages{
        stage('Clone repository') {
            steps {
                git branch: env.BRANCH_NAME, changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/BhairaviSanskriti/Assignment.git'
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
        /*
         stage('Terraform Destroy') {
            steps {
                sh 'terraform destroy -auto-approve'    
            }
        }
        */
       stage('Update Kube Config') {
            steps {
                sh 'aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)'
            }
        }
        stage('Check Namespace') {
            steps {
                /*Check whether argocd namespace is already created or not!*/
                sh'''
                    argocd_ns=$(kubectl get namespace argocd 2>/dev/null)
                    if [[ "$argocd_ns" != "argocd"* ]]; then
                      kubectl create namespace argocd
                    fi
                '''
            }
        }
        
        stage('Install ArgoCD APP & CLI') {
            steps {
                sh 'kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml'
                sh 'sudo -S curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.7/argocd-linux-amd64'
                sh 'sudo -S chmod +x /usr/local/bin/argocd'
                sh 'kubectl patch svc argocd-server -n argocd -p \'{"spec": {"type": "LoadBalancer"}}\''
                sh 'sleep 5'
            }
        }

        stage('ArgoCD Login') {
            steps {
                sh "sudo chmod +x login.sh"
                sh "./login.sh"
            }
        }

        stage('Deploy Nginx Application') {
            steps {
                sh "sudo chmod +x deploy_nginx.sh"
                sh "./deploy_nginx.sh"
            }
        }
    }
        
}

