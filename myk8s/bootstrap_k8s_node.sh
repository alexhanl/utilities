#!/bin/bash


k8s_version=1.20.10

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.8   lb.example.com       lb
172.42.42.101 kmaster1.example.com kmaster1
172.42.42.102 kmaster2.example.com kmaster2
172.42.42.103 kmaster3.example.com kmaster3
172.42.42.201 kworker1.example.com kworker1
172.42.42.202 kworker2.example.com kworker2
172.42.42.203 kworker3.example.com kworker3
EOF

# Install docker from Docker-ce repository
echo "[TASK 2] Install docker container engine"
echo "executing 2.1"
yum install -y -q yum-utils device-mapper-persistent-data lvm2 wget --nogpgcheck
echo "executing 2.2"
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
echo "executing 2.3"
yum makecache
echo "executing 2.4"
yum install -y -q docker-ce-19.03.15 docker-ce-cli-19.03.15 --nogpgcheck

mkdir /etc/docker

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable docker 
systemctl start docker
usermod -aG docker vagrant

# # add harbor trust
# mkdir -p /etc/docker/certs.d/myharbor.example.com/
# cp /vagrant/myharbor.example.com.key /etc/docker/certs.d/myharbor.example.com/
# cp /vagrant/myharbor.example.com.cert /etc/docker/certs.d/myharbor.example.com/
# cp /vagrant/ca.crt /etc/docker/certs.d/myharbor.example.com/
# chown root:root /etc/docker/certs.d/myharbor.example.com/myharbor.example.com.key
# chown root:root /etc/docker/certs.d/myharbor.example.com/myharbor.example.com.cert
# chown root:root /etc/docker/certs.d/myharbor.example.com/ca.crt
# systemctl restart docker

# Disable SELinux
echo "[TASK 4] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "[TASK 5] Stop and Disable firewalld"
systemctl disable firewalld 
systemctl stop firewalld

# Add sysctl settings
echo "[TASK 6] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system 

# Disable swap
echo "[TASK 7] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add yum repo file for Kubernetes
echo "[TASK 8] Add yum repo file for kubernetes"
cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# Install Kubernetes
echo "[TASK 9] Install Kubernetes (kubeadm, kubelet and kubectl)"
yum install -y -q kubeadm-${k8s_version} kubelet-${k8s_version} kubectl-${k8s_version} --nogpgcheck

# Start and Enable kubelet service
echo "[TASK 10] Enable and start kubelet service"
systemctl enable kubelet 
systemctl start kubelet 

# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 12] Set root password"
echo "kubeadmin" | passwd --stdin root 

# Update vagrant user's bashrc file
echo "[TASK 13] Update bashrc file"
echo "export TERM=xterm" >> /etc/bashrc

# Installing git
echo "[TASK 14] Installing necessary packages - git,bash-completion,nfs-utils"
yum install -y -q git --nogpgcheck
yum install -y -q bash-completion
yum install -y -q nfs-utils

echo "[TASK 15] loading docker images"
find /vagrant/images -type f -name *.tar -exec docker load -i {} \;
