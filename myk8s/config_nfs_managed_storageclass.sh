vagrant ssh kmaster -c 'sudo /vagrant/config_nfs_server_kmaster.sh'

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install nfs-storage nfs-subdir-external-provisioner/nfs-subdir-external-provisioner -n kube-system \
    --set nfs.server=172.42.42.101 \
    --set nfs.path=/nfs-share \
    --set storageClass.name=managed-nfs-storage \
    --set storageClass.defaultClass=true \
    --set storageClass.archiveOnDelete=false


#  wget https://get.helm.sh/helm-v2.16.6-linux-amd64.tar.gz
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

