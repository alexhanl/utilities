# TKGm environment setup

## Reference
- https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-index.html
- https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-tanzu-cli-reference.html

## 下载软件包
1. 删除现有AVI中的 static routing 配置 （one cloud demo 环境中）
2. 下载软件包 

## 安装必要的工具
```bash
bash install-cli-tools.sh
```

## 部署 Tanzu management cluster
```bash
tanzu management-cluster create --ui --timeout 8h
```
或者
```bash
tanzu management-cluster create tkg-mgmt --file tkg-mgmt.yaml -v 6
```

验证安装结果
```bash
tanzu login
tanzu management-cluster get
kubectl config use-context tkg-mgmt-admin@tkg-mgmt
kubectl get pod -A
```

## 安装 Tanzu workload cluster （tkc） 
```bash
tanzu cluster create tkc-01 -f tkc-01.yaml
tanzu cluster list
tanzu cluster kubeconfig get tkc-01 --admin
kubectl config use-context tkc-01-admin@tkc-01
```

## 安装必要的插件
```bash
tanzu cluster kubeconfig get tkc-01 --admin
kubectl config use-context tkc-01-admin@tkc-01
```

```bash
kubectl create ns my-packages
```

install cert-manager
```bash
tanzu package install cert-manager --package-name cert-manager.tanzu.vmware.com --namespace my-packages --version 1.5.3+vmware.2-tkg.1 
tanzu package installed list -A
```

install contour
```bash
kubectl create clusterrolebinding envoy-tkg-admin-privileged-binding --clusterrole=psp:vmware-system-privileged --serviceaccount=tanzu-system-ingress:envoy

tanzu package available get contour.tanzu.vmware.com/1.18.2+vmware.1-tkg.1 --values-schema

tanzu package install contour \
--package-name contour.tanzu.vmware.com \
--version 1.18.2+vmware.1-tkg.1 \
--values-file contour-data-values.yaml \
--namespace my-packages

```


