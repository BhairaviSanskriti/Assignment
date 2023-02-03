#!/bin/bash


# CONTEXT_NAME=`kubectl config view -o jsonpath='{.current-context}'`


CONTEXT_NAME=`kubectl config get-contexts -o name`

kubectl config use-context $CONTEXT_NAME

export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`

export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd cluster add $CONTEXT_NAME

argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure


# argocd cluster add $(terraform output -raw cluster_name) --server $(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')

# argocd cluster add $(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')


