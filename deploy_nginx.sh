#!/bin/bash

kubectl create namespace nginx-app

argocd app create nginx-application --repo https://github.com/BhairaviSanskriti/Test-Jenkins.git --path ./deployments/nginx --dest-server https://kubernetes.default.svc --dest-namespace nginx-app

argocd app sync nginx-application

kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'
