# ======================== #
# VMware VMs configuration #
# ======================== #

vm-count = "1"
vm-name = "centos"
vm-template-name = "CentOS7-Template"
vm-cpu = 2
vm-ram = 2048
vm-guest-id = "centos7_64Guest"

# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "vcsa-01a.corp.local"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = "administrator@vsphere.local"

# VMware vSphere password used to deploy the infrastructure
vsphere-password = "VMware1!"

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "RegionA01"

# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "RegionA01-MGMT"

# vSphere Datastore used to deploy VMs 
vm-datastore = "map-vol"

# vSphere Network used to deploy VMs 
vm-network = "VM Network"

# Linux virtual machine domain name
vm-domain = "corp.tanzu"
