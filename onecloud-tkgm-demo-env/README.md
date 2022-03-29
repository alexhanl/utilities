# TKGm environment setup

## Reference
- https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-index.html
- https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-tanzu-cli-reference.html

## 下载软件包
1. 删除现有AVI中的 static routing 配置 （仅限于 one cloud demo 环境中）
2. 下载软件包: https://customerconnect.vmware.com/en/downloads/info/slug/infrastructure_operations_management/vmware_tanzu_kubernetes_grid/1_x

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

## 更新插件 Antrea as an example， 以支持 antrea egress gateway 功能 (https://antrea.io/docs/v1.2.3/docs/egress/)
https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/vmware-tanzu-kubernetes-grid-15/GUID-packages-update-addons.html

确保在 tkg-mgmt-admin@tkg-mgmt context 中：
kubectl config use-context tkg-mgmt-admin@tkg-mgmt


```bash
kubectl get -n tkg-system secret tkg-mgmt-antrea-addon -o jsonpath={.data.values\\.yaml} | base64 -d > mgmt-values.yaml

kubectl get secret tkc-01-antrea-addon -o jsonpath={.data.values\\.yaml} | base64 -d > tkc-01-antrea-data-values.yaml
kubectl get secret tkc-01-antrea-addon -o yaml > tkc-01-antrea.yaml

```

修改 tkc-01-antrea-data-values.yaml，其中增加 "Egress: True", 然后将此文件内容进行base64 encoding，然后替换 tkc-01-antrea.yaml 相应部分, save as tkc-01-antrea-updated.yaml。 
```
cat tkc-01-antrea-values.yaml | base64 -w 0
```
```
kubectl apply -f tkc-01-antrea-updated.yaml
```

### 检查配置是否生效
1. 在 management cluster 中， 确认刚刚的修改已经生效
```
kubectl get secret tkc-01-antrea-addon -o jsonpath={.data.values\\.yaml} | base64 -d 
```

2. 在 workload cluster 中，确认 antrea-agent.conf 以及 antrea-controller.conf 中都包含 "Egress: True"
```
kubectl get configmap -n kube-system antrea-config-822fk25299 -o yaml 
```

3. kill the pods to reload the new configmap 
kubectl get po -A | grep -i antrea

### 验证Egress Gateway 功能，参考 reference/antrea-egress-gateway.yaml
外部设置一个 avi 的 virtual service，设置 log 所有的 non-significant 日志。 
创建一个curl pod， 然后进入Pod， 执行 curl http://192.168.220.7
检查 avi 的 log，看到 client ip 为 192.168.130.140 的访问


## external-DNS
https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/rfc2136.md


yq -i eval '... comments=""' external-dns-data-values.yaml

tanzu package install external-dns \
--package-name external-dns.tanzu.vmware.com \
--version 0.10.0+vmware.1-tkg.1 \
--values-file external-dns-data-values.yaml \
--namespace my-packages

### TODO：Kerberos


## TODO: 天池

## TODO: kubesphere for OIDC

## TODO: pinniped

## TODO: TMC

## Shared Services Cluster



Deploy VMware Tanzu Packages from a private Container Registry  
https://rguske.github.io/post/deploy-tanzu-packages-from-a-private-registry/