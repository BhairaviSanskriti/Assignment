# Getting Started

## About
In this project, I have created a Jenkins pipeline for continuous provisioning of infrastructure and also continuous deployment of the nginx application.

## Tools
I have used the following tools and services to build the project:
- **Jenkins**:  for building the pipeline and automated provisioning and deployment
- **Amazon EKS**: We will create an EKS cluster
- **Terraform**: The IaC tool for provisioning the EKS cluster
- **GitOps ArgoCD**: This tool will ensure continuous deployment of the nginx application.

## Repository Structure
Let's first understand the contents of various files and the directory of this repository.
1. The `deployments` directory:
    - This directory contains the manifest files for the applications deployed on the EKS cluster using ArgoCD.
2. The `Jenkinsfile`:
    - This file contains the definition of our desired Jenkins pipeline.
    - It has various stages and steps to meet our requirement. Some are *Clone repository*, *Terraform Init*, *Terraform Plan*, *Terraform Apply*, *Install ArgoCD* and *Deploy Nginx Application*.
3. The *login.sh* and *deploy_nginx.sh* files:
    - These scripting file are used in *Jenkinsfile* to login to argocd application and deploy the nginx app respectively.
4. The *main.tf*, *terraform.tf*, *variables.tf* and *outputs.tf* files:
    - These file contains the infrastructure code for provisioning the Amazon EKS cluster.
    - This file will create a VPC cluster, an EKS cluster and Amazon managed node groups.

## Steps
### 1. Prerequisite
- AWS account
- GitHub account
### 2. Set up a Jenkins Server
- Install Jenkins on either an EC2 instance or your local machine.
- Install the required plugins.
- Install additional plugins like Terraform, CloudBees AWS Credentials, GitHub Integration, EKS Token and plugins realted to Kubernetes etc.
- Add credentials in Jenkins for your Github and AWS account. For AWS credentials, use CloudBees AWS Credentials plugin that we installed earlier.
- Make sure that the following are installed on your machine where Jenkins server is running:
  - `aws` cli
  - `kubectl` cli
  - `terraform` cli
- Jenkins is also executing `sudo` commands. So, make sure to give sudo privileges to Jenkins.
### 2. Create a Jenkins pipeline
- Create a Jenkins pipeline and select SCM. Uses this repository's link as the url to provide *Jenkisfile*.
- Click on 'Build Pipeline'.
- It will take some time to provision the infra.
- After the build completes you can check the ArgoCD server url to see the deployment status of the nginx application.

## Conclusion
Using Jenkins, you can automate the infrastructure provisioning and continuous deployment.
