govc vm.clone -vm CentOS7-Template -c=2 -m=2048 -on=false centos-a 
# govc vm.power -s=true  -wait=true centos-a
govc vm.customize -vm centos-a -type=Linux -name=centos-a -ip=192.168.110.201 -netmask=255.255.255.0 -gateway=192.168.110.1 -dns-server=192.168.110.10 -domain=corp.local 
govc vm.power -on centos-a
