```bash
tanzu package available list -A
```

```bash
tanzu package installed list -A
```

```bash
tanzu package installed get contour --namespace my-packages
```


kubeconfig file location:  .kube-tkg/config

tanzu management-cluster kubeconfig get --admin
tanzu cluster kubeconfig get tkc-02 --admin


imgpkg pull -b projects.registry.vmware.com/tkg/packages/core/antrea:v1.2.3_vmware.4-tkg.1-advanced -o antrea

imgpkg pull -b projects.registry.vmware.com/tkg/packages/core/antrea:v1.2.3_vmware.4-tkg.1-advanced -o antrea







```console
ubuntu@cli-vm:~$ tanzu package available list -A
- Retrieving available packages... I0320 23:58:10.908208  236140 request.go:665] Waited for 1.015630565s due to client-side throttling, not priority and fairness, request: GET:https://192.168.220.2:6443/apis/node.k8s.io/v1beta1?timeout=32s
- Retrieving available packages...
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
  core-management-plugins.tanzu.vmware.com            core-management-plugins            CLIPlugin management                                                                                                         0.11.1-92-g4d578570+vmware.1   tkg-system
  featuregates.tanzu.vmware.com                       featuregates                       Feature management                                                                                                           0.11.1-92-g4d578570+vmware.1   tkg-system
  kapp-controller.tanzu.vmware.com                    kapp-controller                    Kubernetes package manager                                                                                                   0.30.0+vmware.1-tkg.1          tkg-system
  load-balancer-and-ingress-service.tanzu.vmware.com  load-balancer-and-ingress-service  Provides L4+L7 load balancing for TKG clusters running on vSphere                                                            1.6.1+vmware.2-tkg.3           tkg-system
  metrics-server.tanzu.vmware.com                     metrics-server                     Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines.  0.5.1+vmware.1-tkg.1           tkg-system
  pinniped.tanzu.vmware.com                           pinniped                           Pinniped provides identity services to Kubernetes.                                                                           0.12.0+vmware.1-tkg.1          tkg-system
  secretgen-controller.tanzu.vmware.com               secretgen-controller               Secret generation and sharing                                                                                                0.7.1+vmware.1-tkg.1           tkg-system
  vsphere-cpi.tanzu.vmware.com                        vsphere-cpi                        vSphere Cloud Provider Interface                                                                                             1.22.4+vmware.1-tkg.1          tkg-system
  vsphere-csi.tanzu.vmware.com                        vsphere-csi                        vSphere CSI provider                                                                                                         2.4.1+vmware.1-tkg.1           tkg-system
ubuntu@cli-vm:~$

```
