
https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-index.html


1. 删除现有AVI中的 static routing 配置


tar zxvf tanzu-cli-bundle-linux-amd64.tar.gz
cd cli
sudo install core/v0.11.1/tanzu-core-linux_amd64 /usr/local/bin/tanzu
tanzu init
tanzu plugin clean
tanzu plugin sync
tanzu plugin list

gzip -d kubectl-linux-v1.22.5+vmware.1.gz
chmod ugo+x kubectl-linux-v1.22.5+vmware.1
sudo install kubectl-linux-v1.22.5+vmware.1 /usr/local/bin/kubectl

cd cli
gunzip ytt-linux-amd64-v0.35.1+vmware.1.gz
chmod ugo+x ytt-linux-amd64-v0.35.1+vmware.1
sudo mv ./ytt-linux-amd64-v0.35.1+vmware.1 /usr/local/bin/ytt

gunzip kapp-linux-amd64-v0.42.0+vmware.1.gz
chmod ugo+x kapp-linux-amd64-v0.42.0+vmware.1
sudo mv ./kapp-linux-amd64-v0.42.0+vmware.1 /usr/local/bin/kapp

gunzip kbld-linux-amd64-v0.31.0+vmware.1.gz
chmod ugo+x kbld-linux-amd64-v0.31.0+vmware.1
sudo mv ./kbld-linux-amd64-v0.31.0+vmware.1 /usr/local/bin/kbld

gunzip imgpkg-linux-amd64-v0.18.0+vmware.1.gz
chmod ugo+x imgpkg-linux-amd64-v0.18.0+vmware.1
sudo mv ./imgpkg-linux-amd64-v0.18.0+vmware.1 /usr/local/bin/imgpkg



tanzu management-cluster create --ui --timeout 8h


tanzu login
tanzu management-cluster get
kubectl config use-context tkg-mgmt-admin@tkg-mgmt


tanzu cluster create tkc-01 -f tkc-01.yaml
tanzu cluster list
tanzu cluster kubeconfig get tkc-01 --admin
kubectl config use-context tkc-01-admin@tkc-01



tanzu management-cluster create tkg-mgmt --file tkg-mgmt.yaml -v 6


tanzu management-cluster create --file ~/tkg-mgmt.yaml
tanzu management-cluster kubeconfig get --admin

tanzu cluster create -f tkc-01.yaml
tanzu cluster kubeconfig get tkc-01 --admin





