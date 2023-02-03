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
        
        stage('Update Kube Config') {
            steps {
                sh 'aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)'
            }
        }
        
        stage('Install ArgoCD') {
            steps {
                sh 'kubectl create namespace argocd'
                sh 'kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml'
                sh 'sudo -S curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.7/argocd-linux-amd64'
                sh 'sudo -S chmod +x /usr/local/bin/argocd'

                sh 'kubectl patch svc argocd-server -n argocd -p \'{"spec": {"type": "LoadBalancer"}}\''
                sh 'export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output \'.status.loadBalancer.ingress[0].hostname\'`'
                sh 'export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`'
                sh 'argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure'

                sh 'CONTEXT_NAME="kubectl config view -o jsonpath=\'{.current-context}\'"'
                sh 'argocd cluster add $CONTEXT_NAME'
            }
        }
        stage('Install Nginx Application') {
            steps {
                sh 'kubectl create namespace nginx-app'
                sh 'argocd app create nginx-application --repo https://github.com/BhairaviSanskriti/Test-Jenkins.git --path ./deployments/nginx --dest-server https://kubernetes.default.svc --dest-namespace nginx-app'
                sh 'argocd app sync nginx-application'
                sh 'echo $ARGOCD_SERVER'
            }
        }
    }
}
