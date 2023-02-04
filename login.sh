#!/bin/bash

CONTEXT_NAME=`kubectl config get-contexts -o name`

kubectl config use-context $CONTEXT_NAME

export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`

export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd cluster add $CONTEXT_NAME -y

argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure
