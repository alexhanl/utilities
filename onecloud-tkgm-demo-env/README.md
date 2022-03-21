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

```bash
tanzu package available list -A
```
```
NAME                                                DISPLAY-NAME                       SHORT-DESCRIPTION                                                                                                            LATEST-VERSION                 NAMESPACE
  cert-manager.tanzu.vmware.com                       cert-manager                       Certificate management                                                                                                       1.5.3+vmware.2-tkg.1           tanzu-package-repo-global
  contour.tanzu.vmware.com                            contour                            An ingress controller                                                                                                        1.18.2+vmware.1-tkg.1          tanzu-package-repo-global
  external-dns.tanzu.vmware.com                       external-dns                       This package provides DNS synchronization functionality.                                                                     0.10.0+vmware.1-tkg.1          tanzu-package-repo-global
  fluent-bit.tanzu.vmware.com                         fluent-bit                         Fluent Bit is a fast Log Processor and Forwarder                                                                             1.7.5+vmware.2-tkg.1           tanzu-package-repo-global
  grafana.tanzu.vmware.com                            grafana                            Visualization and analytics software                                                                                         7.5.7+vmware.2-tkg.1           tanzu-package-repo-global
  harbor.tanzu.vmware.com                             harbor                             OCI Registry                                                                                                                 2.3.3+vmware.1-tkg.1           tanzu-package-repo-global
  multus-cni.tanzu.vmware.com                         multus-cni                         This package provides the ability for enabling attaching multiple network interfaces to pods in Kubernetes                   3.7.1+vmware.2-tkg.2           tanzu-package-repo-global
  prometheus.tanzu.vmware.com                         prometheus                         A time series database for your metrics                                                                                      2.27.0+vmware.2-tkg.1          tanzu-package-repo-global
  addons-manager.tanzu.vmware.com                     tanzu-addons-manager               This package provides TKG addons lifecycle management capabilities.                                                          1.5.0+vmware.1-tkg.3           tkg-system
  ako-operator.tanzu.vmware.com                       ako-operator                       NSX Advanced Load Balancer using ako-operator                                                                                1.5.0+vmware.4-tkg.1           tkg-system
  antrea.tanzu.vmware.com                             antrea                             networking and network security solution for containers                                                                      1.2.3+vmware.4-tkg.1-advanced  tkg-system
  calico.tanzu.vmware.com                             calico                             Networking and network security solution for containers.                                                                     3.19.1+vmware.1-tkg.3          tkg-system
  kapp-controller.tanzu.vmware.com                    kapp-controller                    Kubernetes package manager                                                                                                   0.30.0+vmware.1-tkg.1          tkg-system
  load-balancer-and-ingress-service.tanzu.vmware.com  load-balancer-and-ingress-service  Provides L4+L7 load balancing for TKG clusters running on vSphere                                                            1.6.1+vmware.2-tkg.3           tkg-system
  metrics-server.tanzu.vmware.com                     metrics-server                     Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines.  0.5.1+vmware.1-tkg.1           tkg-system
  pinniped.tanzu.vmware.com                           pinniped                           Pinniped provides identity services to Kubernetes.                                                                           0.12.0+vmware.1-tkg.1          tkg-system
  secretgen-controller.tanzu.vmware.com               secretgen-controller               Secret generation and sharing                                                                                                0.7.1+vmware.1-tkg.1           tkg-system
  vsphere-cpi.tanzu.vmware.com                        vsphere-cpi                        vSphere Cloud Provider Interface                                                                                             1.22.4+vmware.1-tkg.1          tkg-system
  vsphere-csi.tanzu.vmware.com                        vsphere-csi                        vSphere CSI provider                                                                                                         2.4.1+vmware.1-tkg.1           tkg-system
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

tanzu package installed get contour --namespace my-packages
```


