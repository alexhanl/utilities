minikube start --cpus=4 --memory=12g  --kubernetes-version v1.20.7 --driver=virtualbox --bootstrapper=kubeadm --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook --extra-config=scheduler.address=0.0.0.0 --extra-config=controller-manager.address=0.0.0.0