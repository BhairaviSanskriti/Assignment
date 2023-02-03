#!/bin/bash

export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`

export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

echo 'Logged in to the server'

CONTEXT_NAME=`kubectl config view -o jsonpath='{.current-context}'`

echo "$CONTEXT_NAME: this context is to be added"

argocd cluster add $(terraform output -raw cluster_name) --server $(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')

echo "context is added"
