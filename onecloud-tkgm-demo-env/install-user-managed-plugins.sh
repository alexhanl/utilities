# tanzu cluster kubeconfig get tkc-01 --admin
# kubectl config use-context tkc-01-admin@tkc-01

kubectl create ns my-packages

echo "--- installing cert-manager ---"
tanzu package install cert-manager \
--package-name cert-manager.tanzu.vmware.com \
--namespace my-packages \
--version 1.5.3+vmware.2-tkg.1 

echo "--- installing contour ---"
kubectl create clusterrolebinding envoy-tkg-admin-privileged-binding \
--clusterrole=psp:vmware-system-privileged \
--serviceaccount=tanzu-system-ingress:envoy

tanzu package install contour \
--package-name contour.tanzu.vmware.com \
--version 1.18.2+vmware.1-tkg.1 \
--values-file contour-data-values.yaml \
--namespace my-packages

echo "--- installing external-dns ---"
tanzu package install external-dns \
--package-name external-dns.tanzu.vmware.com \
--version 0.10.0+vmware.1-tkg.1 \
--values-file external-dns-data-values.yaml \
--namespace my-packages
