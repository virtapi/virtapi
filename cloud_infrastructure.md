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

This setup was acquired and reviewed by multiple system engineers and currently covers all their needs. The focus is on managing a QEMU platform with puppet or salt. Other hypervisors are also implemented to support a long-range migration from them to QEMU.

QEMU supports a wide range of blockdevice types, the local ones are mostly QCOW2, RAW images or LVM2 volumes. The API will support them and Ceph for RAW images. Ceph is a distributed block and object store. It works fine with 10GBit or multiple 1GBit links, you can even install it beside QEMU on the same physical host system. Compared to dedicated ceph nodes, this will reduce the needed network ports by 50%. Ceph offers a scaleable and fault tolerant storage. It is easy to increase the storage amount or the IOPS by adding more OSDs or journal SSDs. Also VM migration takes less time because you only need to sync the virtual memory and not the whole local storage. compared to local storage on multiple hypervisors, ceph is able to use the harddisks and SSDs more efficient. A block device is divied into multiple parts, they are distributed across the whole cluster which results in a consistent harddisk/SSD allocation.

In my opinion, it should be possible to develop this API including the cloud infrastrucute with two developers and one or two system engineers in 8 weeks. This should be enough time to develop a working environment that is able to deploy and modify virtul maschines via a RESTfull API or the corresponding webinterface.
