

redhat kickstart syntax reference: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-syntax

```
wget https://mirror.umd.edu/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
govc datastore.mkdir -ds map-vol ISO
govc datastore.upload -ds map-vol ./CentOS-7-x86_64-DVD-2009.iso ISO/CentOS-7-x86_64-DVD-2009.iso

packer build centos-vsphere.json
```