kubectl vsphere login --server wcp.corp.tanzu -u administrator@vsphere.local --tanzu-kubernetes-cluster-namespace tkg --tanzu-kubernetes-cluster-name tkg-demo
kubectl config use-context tkg-demo