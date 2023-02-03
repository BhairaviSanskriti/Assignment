#!/bin/bash


kubectl create namespace nginx-ns

argocd app create nginx-app --repo https://github.com/BhairaviSanskriti/ecsdemo-nodejs.git --path deployments/nginx --dest-server https://kubernetes.default.svc --dest-namespace nginx-ns

argocd app sync nginx-app
