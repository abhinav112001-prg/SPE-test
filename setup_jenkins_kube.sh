#!/bin/bash
# Setup kubectl access for Jenkins user to reach Minikube
set -e

echo "Creating directories..."
sudo mkdir -p /var/lib/jenkins/.kube
sudo mkdir -p /var/lib/jenkins/.minikube/profiles/minikube

echo "Copying kubeconfig..."
sudo cp /home/abhinav-sharma/.kube/config /var/lib/jenkins/.kube/config

echo "Copying minikube certificates..."
sudo cp /home/abhinav-sharma/.minikube/ca.crt /var/lib/jenkins/.minikube/
sudo cp /home/abhinav-sharma/.minikube/profiles/minikube/client.crt /var/lib/jenkins/.minikube/profiles/minikube/
sudo cp /home/abhinav-sharma/.minikube/profiles/minikube/client.key /var/lib/jenkins/.minikube/profiles/minikube/

echo "Updating paths in kubeconfig..."
sudo sed -i "s|/home/abhinav-sharma|/var/lib/jenkins|g" /var/lib/jenkins/.kube/config

echo "Setting ownership..."
sudo chown -R jenkins:jenkins /var/lib/jenkins/.kube /var/lib/jenkins/.minikube

echo "Verifying..."
sudo -u jenkins kubectl --kubeconfig=/var/lib/jenkins/.kube/config cluster-info 2>&1 | head -3

echo "Done! Jenkins can now access Minikube."

