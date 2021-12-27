
# yum install -y nfs-utils

mkdir /nfs-share
chmod -R 777 /nfs-share
echo "/nfs-share 172.42.42.0/24(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports

systemctl restart rpcbind.service 
systemctl restart nfs.service

systemctl enable rpcbind.service
systemctl enable nfs.service

showmount -e
