#Implementing a KVM based Cloud Infrastructure

QEMU is a widly tested and deployed Hypervisor for full virtualization. It is licensed under the GNU GPL2. QEMUs KVM addon allows paravirtualizated hardware instead of fully emulated hardware. This leads to an overhead under 10-5% compared to real hardware. 

A cloud infrastructure with KVM/QEMU offers several features:
+ Open Source → no license costs
+ live increase number of vCPUs
+ hot add memory
+ KSM for memory overcommitment
+ Memory ballooning (only allocate used ram, release free ram)
+ Support for local, central and shared storage
+ blockdevices only allocate used space → efficient storage usage
+ Supports every operating system inside virtual maschines
+ Migrating VMs from one hostsystem to another one with different CPUs
+ widly tested and stable hypervisor

QEMU is a great and powerfull hypervisor, but it doesn't offer any RESTfull like interfaces for management. As part of my computer engineering studying, I created a draft for an API. This draft is available at: https://github.com/virtapi/virtapi

It currently coffers:
+ the relationships between the resources, displayed as an ERD
+ A list of requirements for the API itself and the created infrastructure
+ A comparsion of alternative projects and an explanation why they aren't suitable for big cloud environments

This setup was acquired and reviewed by multiple system engineers and currently covers all their needs. The focus is on managing a QEMU platform with  puppet or salt.

In my opinion, it should be possible to develop this API including the cloud infrastrucute with two developers and one or two system engineers in 8 weeks. This should be enough time to develop a working environment that is able to deploy and modify virtul maschines via a RESTfull API or the corresponding webinterface.
