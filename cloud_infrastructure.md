#Implementing a KVM based Cloud Infrastructure

QEMU is one of the industry standard hypervisors for full hardware virtualization. It is licensed under the GNU GPL2, a common open source license and used by SUSE and RedHat in there cloud products. QEMUs KVM addon allows for paravirtualized hardware instead of fully emulating it. Due to the paravirualization the overhead compared to real hardware is only around five to ten percent.

A cloud infrastructure with QEMU/KVM offers several features:
+ Open Source → no license costs
+ Live increase number of vCPUs
+ Hot add memory
+ Kernel samepage merging (KSM) for memory overcommitment
+ Memory ballooning (only allocate used ram, release free ram)
+ Support for local, central and shared storage
+ Block devices only allocate used space → efficient storage usage with overcommiting
+ Supports every operating system inside virtual maschines
+ Migrating VMs from one hostsystem to another one with different CPUs
+ wide tested and stable hypervisor

QEMU is a great and powerfull hypervisor, but it doesn't offer any RESTfull like interfaces for management. As part of my computer engineering studying, I created a draft for an API. This draft is available at: https://github.com/virtapi/virtapi

Right now it offers:
+ The relationships between resources, displayed as an ERD
+ A list of requirements for the API itself and the created infrastructure
+ A comparision of alternative projects and an explanation why they aren't suitable for big cloud environments

This setup was acquired and reviewed by multiple system engineers and currently covers all their needs. The focus is on managing a QEMU platform with puppet or salt, industry standard configuration and lifecycle management applications.

In my opinion, it should be possible to develop this API including the cloud infrastrucute with two developers and one or two system engineers in 8 weeks. This should be enough time to develop a working environment that is able to deploy and modify virtual maschines via a RESTfull API or the corresponding webinterface.
