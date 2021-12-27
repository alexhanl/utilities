wget http://repos-lax.psychz.net/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
govc datastore.mkdir -ds=map-vol ISO-Linux
govc datastore.upload -ds map-vol ./CentOS-7-x86_64-DVD-2009.iso ISO-Linux/CentOS-7-x86_64-DVD-2009.iso


cd ../packer && packer build centos-vsphere.json

govc vm.clone -vm CentOS7-Template -c=2 -m=2048 -on=false centos-a 
govc vm.customize -vm centos-a -type=Linux -name=centos-a -ip=192.168.110.201 -netmask=255.255.255.0 -gateway=192.168.110.1 -dns-server=192.168.110.10 -domain=corp.tanzu 
govc vm.power -on centos-a
