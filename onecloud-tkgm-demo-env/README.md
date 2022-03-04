tanzu management-cluster create --file ~/tkg-mgmt.yaml
tanzu management-cluster kubeconfig get --admin

tanzu cluster create -f tkc-01.yaml
tanzu cluster kubeconfig get tkc-01 --admin


