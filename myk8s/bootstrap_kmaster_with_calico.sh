#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.42.42.101 --pod-network-cidr=192.168.0.0/16 \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version=1.20.10

# Below is the stack ha masters configuration 
# 
# sudo kubeadm init --apiserver-advertise-address=172.42.42.101 \
# --control-plane-endpoint "172.42.42.8:6443" \
# --upload-certs --pod-network-cidr=192.168.0.0/16 \
# --image-repository registry.aliyuncs.com/google_containers \
# --kubernetes-version=1.19.12


# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# Deploy Calico network
echo "[TASK 3] Deploy Calico network"
su - vagrant -c "kubectl create -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml"

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh


echo "[TASK 5] source kubectl bash completion and k alias"
su - vagrant -c "source <(kubectl completion bash)" # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
su - vagrant -c "echo 'source <(kubectl completion bash)' >> ~/.bashrc" # add autocomplete permanently to your bash shell.
su - vagrant -c "echo 'alias k=kubectl' >> ~/.bashrc"
su - vagrant -c "echo 'complete -F __start_kubectl k' >> ~/.bashrc"


echo "[TASK 6] install helm"
cd /tmp && tar zxvf /vagrant/helm-v3.7.0-linux-amd64.tar.gz
mv /tmp/linux-amd64/helm /usr/sbin/helm
mkdir -p /etc/bash_completion.d/
helm completion bash > /etc/bash_completion.d/helm