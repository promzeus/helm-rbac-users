#!/bin/bash

USER=$1
NAMESPACE=dev

kubectl config set-cluster $(kubectl config view -o jsonpath='{.clusters[0].name}') \
  --server=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}') \
  --kubeconfig=$USER-k8s-config

CLUSTER_NAME=$(kubectl config view -o jsonpath='{.clusters[0].name}')
kubectl config set clusters.$CLUSTER_NAME.certificate-authority-data $(kubectl get secret --namespace=dev $USER-secret -o jsonpath='{.data.ca\.crt}') \
  --kubeconfig=$USER-k8s-config

kubectl config set-credentials $USER \
  --token=$(kubectl get secret --namespace=$NAMESPACE $USER-secret -o jsonpath='{.data.token}' | base64 -D -) \
  --kubeconfig=$USER-k8s-config

kubectl config set-context $USER \
  --cluster=$(kubectl config view -o jsonpath='{.clusters[0].name}') \
  --namespace=$NAMESPACE \
  --user=$USER \
  --kubeconfig=$USER-k8s-config

kubectl config use-context $USER \
  --kubeconfig=$USER-k8s-config