# Implementing an API to orchestrate a Cloud-Infrastructure

Maintained and created by [Tim Meusel](https://github.com/bastelfreak/)

Contributors:
+ [Sebastian Rakel](https://github.com/sebastianrakel)
+ [Silvio Knizek](https://github.com/killermoehre)
+ [Carsten Menne](https://github.com/taxus13)
+ [Florian Pritz](https://github.com/Bluewind)
+ [Robert Müller](https://github.com/Flipez)

---

## Contents
+ [Project description](#project-description)
    - [Node](#node)
    - [Roles](#roles)
        - [Role Hypervisor](#hypervisor)
        - [Role Ceph OSD node](#ceph-osd-node)
        - [Role Ceph Mon Node](#ceph-mon-node)
    - [Cloud instances](#cloud-instances)
    - [Network interfaces](#network-interfaces)
    - [Storage](#storage)
    - [Node interaction](#node-interaction)
    - [ToDo](#todo)
+ [Requirements](#requirements)
+ [Evaluation of alternatives](#evaluation-of-alternatives)
    - [OpenStack](#openstack)
    - [OpenNebula](#opennebula)
    - [Archipel](#archipel)
+ [Entity Relationship Model](#entity-relationship-model)
+ [Contact](#contact)
+ [Contribution](#contribution)
+ [Links and Sources](#links-and-sources)

---

## Project description
This project aims to provide an open-source API to orchastrate a dynamic cloud infrastructure. The API is licensed under the [GNU Affero General Public License](LICENSE).The goal is to not only manage the host systems, but also the virtual machines itself and storage nodes (ceph) to provide an all-in-one solution that is flexible enough to handle several thousand machines and multiple different virtualization technologies. The API has a focus on secure development to provide an interface for direct customer contact. A description of one possible infrastructure design is available [here](cloud_infrastructure.md). Here is a detailed description for all resources (visualised at [Entity Relationship Model](#entity-relationship-model)):

### Node
Every physical server is described as a resource from the type node (table **node**). Each node has several attributes (multiple IP-Addresses, FQDN...). The IP attributes are mandatory. A node also needs a defined state (attribute **state_id**, table **node_state**), examples are "running", "in maintenance".


### Roles
Every node must have at least one role, the role resource saves the primary key of the node and implements a specific feature on a node (hypervisor, Ceph OSD node...). Each node can implement multipe and even all roles. A role adds not only the role itself but also additional attributes.

#### Hypervisor
This resource (table **virt_node**) implements one or multiple virtualization technologies (table **virt_method**) which are referenced as a N:M relationship (table **node_method**). Each hypervisor has multiple attributes (local storage capacity, the path to a directory for local image files or the LVM2 volume group name for local LVs). He supports multiple local storage formats for virtual machines, they are: QCOW2, RAW and LVM2 LVs. Information about shared storage (table **storage_ceph**) and the block devices for virtual machines (table **storage**) have no direct relation to a hypervisor.

#### Ceph OSD node
The [Ceph OSD Daemon](http://ceph.com/docs/master/rados/configuration/osd-config-ref/) configures multiple persistent storage devices (harddrives, SSDs) and adds them to the global Ceph storage cluster. This resource is a possible role for a node. It is recommended to use a node with multiple free hard disks as OSDs and one or multiple SSDs as a journal cache.

#### Ceph Mon Node
A [Ceph Monitor Daemon](http://ceph.com/docs/master/rados/configuration/mon-config-ref/) (table **ceph_mon_node**) handles the [CRUSH](http://ceph.com/docs/master/rados/operations/crush-map/) map. This resource has currently only one attribute (**port**). It is recommended to use a SSD for the CRUSH map if you're in a big environement.

### Cloud instances
A cloud instance (table **vm**) is also referenced as virtual machine. It has several mandatory attributes (**cores**. **ram** ). One instance has one specific virtualization technology on one node (attribute **virt_node_id**). Like all nodes, also virtual machines have one specific state (attribute **state_id**) based on a predefined list (table **vm_state**). The virtual machine needs at least one persistent storage devices (table **storage**) and one network interface (table **vm_interface**). It is possible to set a limit for the available CPU time (attribute **cputime_limit**)

### Network interfaces
This resource (table **vm_interface**) is assigned to one cloud instance. Each instance can have multiple interfaces (attribute **vm_id**). An interface has currently one attribute (**mac**). Each interface can be part of multiple VLANs (VXLAN) (table **vlan**, several IPv4 (table **ipv4**)and IPv6 (table **ipv6**) addresses can be routed to one interface. The namingconvention for an interface is always **vm_id**-**id**. Each interface gets his own bridge, their name is br-**vm_id**-**id**. It is recommended to set a fix IP<>MAC assignment on the routers and switches. The VLANs allows customers to create own Layer2 networks between multiple virtual machines across several nodes.

### Storage
One storage resource (table **storage**) describes one block device. One virtual machine can have multiple block devies, one device can't be assigned to multiple machines. There are several different storage types (table **storage_type**), each device must be assigned to one type. Each type can have his own table (for exmaple table **storage_ceph**) which implements additional attributes. Each storage resource has multiple attributes (**write_iops_limit**, **read_iops_limit**, **write_bps_limit**, **read_bps_limit**, **size**). There are several cache options available for each storage resource (attribute **cache_option_id**, **cache_option**).

### Node interaction
The paragraph [Requirements](#requirements) defines how people (admins and customers) and external APIs can communicate with this API. But the API itself needs to communicate with the nodes to implement the stuff that is safed in the database. There exists a very long [blog post](https://blog.bastelfreak.de/?p=1212) that evaluates several possible solutions. The conclusion is that mostly ssh is used in other application, but that has several disadvantages. It is way better to implement such interaction with existing configuration mangement tools like [Puppet](https://puppetlabs.com/puppet/what-is-puppet) or [Salt](http://saltstack.com/). This means that the API needs to support Puppets [ENC](https://docs.puppetlabs.com/guides/external_nodes.html) and [Hiera](https://docs.puppetlabs.com/hiera/) (via [hiera-http](https://github.com/crayfishx/hiera-http) or [heira-rest](https://github.com/binford2k/hiera-rest))feature and Salts [external pillars](http://docs.saltstack.com/en/latest/topics/development/external_pillars.html).

### ToDo
+ Implement automatic backups for all storage types
+ Dedicated backup network on each node
+ Dedicated storage network on each node
+ Snapshots for storage resources
+ Update the [create_virt_node](sources/database/procedures/create_virt_node.sql) procedure (more infos inside the file)
+ Add more information about the installimage
+ Validate [Open vSwitch](http://openvswitch.org/). It offers many cool featues but it is complex, do we really need it?
+ Update Ceph tables
+ Implement Ceph secret handling (who knows how this works?)
+ Difference between hiera lookup and ENC in Puppet?
+ Do we want a golden Image that can be mounted (read only) in multiple virtual machines?
+ Normalize node.bond_interfaces

## Requirements
+ The API needs to implement the REST paradigm
+ The API is synchronous (it acknowledges the successfull save of a request in the database, not the successfull receive of a request)
+ The API needs to be created with a opensource framework like [Rails](http://rubyonrails.org/), [Rails::API](https://github.com/rails-api/rails-api), [Sinatra](http://www.sinatrarb.com/), [Django](https://www.djangoproject.com/) or [Flask](http://flask.pocoo.org/)
+ The API must offer an interactive shell like [irb](http://ruby-doc.org/stdlib-2.0/libdoc/irb/rdoc/IRB.html)/[pry](http://pryrepl.org/)
+ The API must support JSON, [MessagePack](http://msgpack.org/) and HTML output
+ There shouldn't be any SPOFs in the deployed infrastructure (like Neutron nodes in OpenStack)
+ Support Puppet ENC/Hiera and Salt external pillar to interact with nodes (take a look at [Node interaction](#node-interaction))
+ Support multiple hypervisor with local and shared storage

## Evaluation of alternatives
All requirements should be listed in the paragraphs [Project description](#project-description) and [Requirements](#requirements). Here is a list of alternative solutions for APIs/webinterfaces and justification why we can't use them.

### OpenStack
[Openstack](https://www.openstack.org/) is a huge framework for a public cloud infrastructure. Sadly, it doesn't scale in big environments and offers a few SPOFs (for example their Neutron service which routes all traffic through a single server). This isn't an acceptable solution for datacenter grade setups.

### OpenNebula
[OpenNebula](http://opennebula.org/) calls itself "enterprise ready", their codebase has a low quality and consistsof a bunch of scripts in different languages. They do dangarous concat in C++ to create libvirts Domain.xml instead of using any available xml lib. You've to stop a virtual machine for most of the possible modifications (for example adding the KVM RTC). Often it is necessary to update the database by hand (via mysql cli). Several basic features like CD hotplug doesn't work. Feature requests are often postponed in the backlog.

### Archipel
[Archipel](http://archipelproject.org/) is an awesome and fancy webapp which runs completly in your browser and communicates via websockts with the server. The protocol is XMPP, each node needs to run the Archipel agent. Sadly, the project has only one active developer and many bugs, their isn't any big progress, the development is almost dead.

---

## Entity Relationship Model
You can find the latest ERD from the current branch [here](sources/database/images/virtapi.svg).

---

## Contact
You can meet us in #virtapi at freenode.

---

## Contribution
We've defined our contribution rules in [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Links and Sources
+ [API Design Guide](https://github.com/interagent/http-api-design)
+ [Ceph Talk at GPN15](https://media.ccc.de/browse/conferences/gpn/gpn15/gpn15-6629-ceph.html#video)
+ [Sinatra MVC Framework](http://www.sitepoint.com/build-a-sinatra-mvc-framework/)
+ [Sinatra Modular vs. Classic Style](https://github.com/sinatra/sinatra#modular-vs-classic-style)
+ [Using Sinatra the modular way](https://www.safaribooksonline.com/library/view/sinatra-up-and/9781449306847/ch04.html)
+ [Sinatra with Rails-like MVC pattern](https://stackoverflow.com/questions/30421971/how-to-map-routes-to-controllers-in-sinatra/30470141#30470141)
+ [Combining Sinatra and Active Record](http://tutorials.jumpstartlab.com/topics/sinatra_with_active_record.html)
+ [Active Record Associations](http://guides.rubyonrails.org/association_basics.html#the-belongs-to-association)
+ [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
+ [Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)
+ [Dealing with json + html in Sinatra](https://github.com/Flipez/faster-than-bastelfreak/blob/master/ftb_app.rb#L22)
+ [Different solutions for Rake Tasks in Sinatra](https://stackoverflow.com/questions/19206764/how-can-i-load-activerecord-database-tasks-on-a-ruby-project-outside-rails)
+ [Gem to support Active Record in Sinatra](https://github.com/janko-m/sinatra-activerecord)
+ [Using Rails Rake Tasks in Sinatra 1](https://gist.github.com/drogus/6087979)
+ [Using Rails Rake Tasks in Sinatra 2](https://gist.github.com/abhiramm/6541592)
+ [Dealing with json in Sinatra](http://www.sinatrarb.com/contrib/json.html)
