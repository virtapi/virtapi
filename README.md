# Implementing an API to orchestrate a Cloud-Infrastructure

Maintained and created by Tim Meusel

Contributors:
+ Sebastian Rakel
+ Silvio Knizek

---

## Contents
+ [Project description](#project-description)
  - [Node](#node)
  - [Role hypervisor](#role-hypervisor)
  - [Role Ceph OSD node](#role-ceph-osd-node)
  - [Role Ceph Mon Node](#role-ceph-mon-node)
  - [Cloud instances](#cloud-instances)
  - [Network interfaces](#network-interfaces)
  - [Storage](#storage)
  - [Todo](#todo)
+ [Requirements](#requirements)
+ [Evaluation of alternatives](#evaluation-of-alternatives)
  - [OpenStack](#openstack)
  - [OpenNebula](#opennebula)
  - [Archipel](#archipel)
+ [Entity Relationship Modell](#entity-relationship-modell)
+ [Use Cases](#use-cases)
  - [Add new virtualization technologies](#add-new-virtualization-technologies)
  - [Add new roles and corresponding nodes](#add-new-roles-and-correspondig-nodes)
  - [Add a whole IPv4 subnet](#add-a-whole-ipv4-subnet)
  - [Add a virtual maschine](#add-a-virtual-maschine)
  - [Install an operating system in a virtual maschine](#install-an-operating-system-in-a-virtual-maschine)
+ [Contact](#contact)
+ [Links and Sources](#links-and-sources)
