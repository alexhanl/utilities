kubectl create ns avi-system
helm repo add ako https://projects.registry.vmware.com/chartrepo/ako
helm install ako-1.5.2 ako/ako --values ./ako-1.5.2-values.yaml --namespace=avi-system --version 1.5.2