#!/bin/bash


kubectl create namespace ecsdemo-nodejs

argocd app create ecsdemo-nodejs --repo https://github.com/BhairaviSanskriti/ecsdemo-nodejs.git --path kubernetes --dest-server https://kubernetes.default.svc --dest-namespace ecsdemo-nodejs

argocd app sync ecsdemo-nodejs

# argocd app sync nginx-application

kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'
