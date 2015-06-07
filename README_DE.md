# Implementierung einer API für die Orchestrierung einer Cloud-Infrastruktur

Tim Meusel – TI114 – Sommer 2015

Contributors:
+ Silvio Knizek
+ Carsten Menne
+ Sebastian Rakel
+ Florian Pritz

---
## Inhaltsverzeichnis
+ [Projektbeschreibung](#projektbeschreibung)
  - [Node](#node)
  - [Rollen](#rollen)
    - [Hypervisor](#hypervisor)
    - [Ceph OSD Node](#ceph-osd-node)
    - [Ceph Monitor Node](#ceph-monitor-node)
  - [Cloud Instanzen](#cloud-instanzen)
  - [Netzwerkinterfaces](#netzwerkinterfaces)
  - [Storage](#storage)
  - [Node Interaktion](#node-interaktion)
  - [ToDo](#todo)
+ [Anforderungen](#anforderungen)
+ [Alternativen](#alternativen)
  - [OpenStack](#openstack)
  - [OpenNebula](#opennebula)
  - [Archipel](#archipel)
+ [Entity Relationship Modell](#entity-relationship-modell)
+ [Use Cases](#use-cases)
  - [Definieren von Virtualisierungstechniken](#definieren-von-virtualisierungstechniken)
  - [Hinzufügen von Nodes](#hinzuf%C3%BCgen-von-nodes)
  - [Hinzufügen eines IPv4 Netzes](#hinzuf%C3%BCgen-eines-ipv4-netzes)
  - [Eintragen einer virtuellen Maschine](#eintragen-einer-virtuellen-maschine)
  - [Übersicht aller Hypervisor und deren unterstützten Techniken](#Übersicht-aller-hypervisor-und-deren-unterstützten-techniken)
  - [Installation einer VM](#installation-einer-vm)
+ [Kontakt](#kontakt)
+ [Links und quellen](#links-und-quellen)

---

## Projektbeschreibung
Mithilfe von Open-Source-Software soll eine API erstellt werden, die eine automatisierte Orchestrierung einer dynamischen Cloud Infrastruktur ermöglicht. Lizensiert sie die API unter der [GNU Affero General Public License](LICENSE).Verwaltet werden sollen zum einen die verschiedenen Hypervisor, die eigentlichen Cloud Instanzen und das Netzwerk. Um einen sicheren Betrieb der API zu gewährleisten, wird diese redundant und skalierbar gebaut. Außerdem wird stark auf die IT-Sicherheit geachtet, da die API nicht nur intern zur Administration genutzt wird, sondern auch Kunden darüber autark Änderungen ihrer Instanzen vornehmen können. Eine Beschreibung der Infrastruktur (auf Englisch) gibt es [hier](cloud_infrastructure.md).

### Node
Ein Node (Tabelle node) bezeichnet immer einen physischen Server. Dieser besitzt verschiedene wichtige Attribute (diverse IP-Adressen, fqdn...). Jeder Node kann mehrere unterschiedliche Rollen implementieren,  aber jede Rolle jeweils nur einmal. Um eine gute Erreichbarkeit zu gewährleisten, hat jeder Node je eine IPv4 und eine IPv6-Adresse.

### Rollen
Jede sperfische Rolle hat einen Node. In einer Tabelle wird die ID des Nodes gespeichert.
#### Hypervisor
Wenn von einem Hypervisor (Tabelle **virt_node**) gesprochen wird, bezieht man sich meist auf das physische Hostsystem für eine beliebige Anzahl von Cloud-Instanzen (Nova Node im Openstack Jargon). Jeder Hypervisor kann verschiedene Virtualisierungstechniken nutzen (Tabelle **virt_method**, Zuordnung in  der Tabelle **node_method**). Lokaler Storage für virtuelle Maschinen kann über *thin provisioned LVM* oder als *raw/QCOW2 Image* (Attribut **local_storage_path**) bereitgestellt werden (Attribut **vg_name**). In beiden Fällen wird der lokal belegbare Speicher definiert (Attribut **local_storage_gb**). Der verteilte Storage (Tabelle **storage** und **storage_ceph**) steht in keiner Relation zum Hypervisor. Jeder Hypervisor muss sich in einem definierten Zustand befinden (Attribut **state_id**, Tabelle **node_state**). Beispiele dafür sind *Running*, *Offline*, *Repair* und *Maintenance*.

#### Ceph OSD Node
Diese Rolle (Tabelle **ceph_osd_node**) implementiert den [Ceph OSD Daemon](http://ceph.com/docs/master/rados/configuration/osd-config-ref/), der mehrere persistente Speicher innerhalb eines Servers zu einem Ceph Storage Verbund konfiguriert.

#### Ceph Monitor Node
Nodes mit dieser Rolle implementieren den [Ceph Monitor Daemon](http://ceph.com/docs/master/rados/configuration/mon-config-ref/) (Tabelle **ceph_mon_node**). Hier ist aktuell nur der Port wichtig, auf dem der Daemon läuft (Attribut **port**).


### Cloud Instanzen
Jede Instanz (Tabelle **vm**) hat fest vorgegebene Ressourcen (Attribute **ram** und **cores**), mindestens einen persistensten Storage (Tabelle **storage**) sowie mindestens eine Netzwerkkarte (*NIC*) (Tabelle **vm_interface**). Zu jeder Netzwerkkarte gehören je eine IPv4 und eine IPv6 Adresse (Tabellen **ipv4** und **ipv6**), sowie optional mehrere VLANs (Tabelle **vlan**). Damit der Kunde stets den aktuellen Status seiner Instanz abfragen kann, werden im Vorfeld  verschiedene Status definiert (*running*, *migrating*, *shut off*) und bei Bedarf in der Datenbank geändert (Attribut **state_id** und Tabelle **vm_state**). Die Zuordnung zum Kunden erfolgt über seine ID (Attribut **customer_id**), welche in der Kundendatenbank definiert ist (nicht Bestandteil dieses Projekts). Um eine zu hohe Ressourcennutzung in einer Public Cloud Infrastruktur zu vermeiden, kann unter anderem ein Limit (Attribut **cputime_limit**) für die zur Verfügung stehende CPU Zeit gesetzt werden.

### Netzwerkinterfaces
Der Name eines virtuellen Interfaces (Tabelle **vm_interface**) setzt sich aus der ID der VM (Attribut **vm_id**) zusammen, gefolgt von einem Bindestrich und dann der Id (Attribut **id**) der Interfaces. Jedem Interface wird eine eigene Bridge mit dem Präfix *br-* zugeordnet. Via VXLAN werden VLANs zwischen den Interfaces realisiert. Jedes in der Datenbank definierte VLAN (Tabelle **vlan**) terminiert an jeder Bridge dessen Interface zum VLAN gehört. Dies ermöglicht es den Kunden, gesicherte Layer2 Verbindungen zwischen ihren Instanzen beliebig zu generieren. Die IP-Adressen (Tabelle **ipv4** und **ipv6**) werden auf die entsprechenden Bridges geroutet. Um eine feste IP<>MAC Zuordnung zu realisieren, wird zu jedem Interface die MAC gespeichert (Attribut **mac**).

### Storage
Ein Storage (Tabelle **storage**) ist immer an eine Instanz gebunden und kann nicht von mehreren Instanzen parallel genutzt werden. Mehrere Storage-Typen sind möglich (Tabelle **storage_type**), z.B. *LVM* oder *QCOW2*. Jede Instanz kann beliebig viele Storage-Einheiten von beliebigen Typen besitzen. Zu jeder Einheit gehört eine definierte Größe (Attribut **size**). Um auch hier eine Ressourceneinhaltung zu gewähren, können diverse Limits gesetzt werden (Attribute **write_iops_limit**, **read_iops_limit**, **write_mbps_limit**, **read_mbps_limit**). Typenspezifische Attribute werden in den Tabellen **storage_TYP** gespeichert, diese hat die gleiche Id wie die eigentliche Entity in der Tabelle **storage**. Um auf die verschiedenen Kundenwünsche einzugehen (besonders schneller oder sicherer Storage) , kann die Cacheoption (Attribut **cache_option_id** und Tabelle **cache_option**) pro Storage-Einheit gesetzt werden.

### Node Interaktion
In den [Anforderungen](#anforderungen) ist definiert, wie User/andere Programme mit der API kommunizieren können. Irgendwie müssen die Daten in der Datenbank aber auch auf den physischen Servern umgesetzt werden. [Hier](https://blog.bastelfreak.de/?p=1212) wurde ausführlich beschrieben, warum Konstrukte via SSH absolut unpraktikabel sind und welche Alternativen man hat. Ein Deployment via [Puppet](https://puppetlabs.com/puppet/what-is-puppet) oder [Salt](http://saltstack.com/) bietet sich hier an. Die API muss also in der Lage sein als [ENC](https://docs.puppetlabs.com/guides/external_nodes.html) und als externe [Hiera](https://docs.puppetlabs.com/hiera/) Quelle (via [hiera-rest](https://github.com/binford2k/hiera-rest) oder [heira-http](https://github.com/crayfishx/hiera-http)) zu dienen. Alternativ wird Salt unterstützt und die API muss als [external_pillar](http://docs.saltstack.com/en/latest/topics/development/external_pillars.html) verfügbar sein.

### ToDo
In folgenden Revisionen werden einige neue Features benötigt, unter anderem:
+ Zeitgesteuerte und planbare Backups pro Instanz
+ Dediziertes Backupnetz an jedem Hypervisor
+ Dediziertes Storagenetz an jedem Hypervisor
+ Snapshots von Storage-Einheiten
+ Procedure **create_virt_nodes** absichern (Infos in der .sql)
+ Text zu *installimage* ergänzen
+ [Open vSwitch](http://openvswitch.org/) ist ein Virtual Switch mit diversen sehr interessanten Features, darunter VLANs, Port-Mirroring, sFlow. OpenFlow, GRE/IPSec Tunnel - leider ist es auch sehr komplex. Es muss noch evaluiert werden, ob sich der Aufwand lohnt ober ob man die benötigten Features nicht anderweitig genauso implementieren kann (bridges + VXLAN).
+ Ceph Tabellen sowie Rollenbeschreibung erweitern
+ Ceph secret Handling implementieren (Wie funktioniert das?)
+ Wie funktionieren external_pillars in Salt?
+ Unterschied zwischen ENC und hiera lookup?
+ Es sollte möglich sein, ein (golden) Image in mehreren VMs parallel einzubinden
+ node.bond_interfaces normalisieren

---

## Anforderungen
+ Die API muss das REST Programmierparadigma implementieren
+ Die API muss synchron sein (sie bestätigt das erfolgreiche speichern eines Requests, nicht die erfolgreiche Annahme)
+ die API muss mit einem Opensource Framework erstellt werden (z.B. Rails, Flask, Django)
+ Die API muss via interaktiver Shell bedienbar sein (z.B. irb/pry)
+ JSON, MessagePack und HTML Support
+ MySQL min. in Version 5.6 (Support für INET6_ATON) oder Postgres
+ Die mit dieser API erstellte Virtualisierungsumgebung sollte keine SPOFs bereitstellen (siehe Neutron Node bei OPenStack)
+ Puppet ENC/Hiera und Salts external Pillar Support (siehe [Node Interaktion](#node-interaktion))
+ Support für verschiedene Hypervisor + lokalen und verteilten Storage

---

## Alternativen
In der [Projektbeschreibung](#Projektbeschreibung) und in den [Anforderungen](#Anforderungen) sind bereits alle benötigten Features erklärt. Nachfolgend eine Auflistung von Alternativen Interfaces/APIs sowie ein Vergleich, warum diese ungeeignet sind.

### OpenStack
[Openstack](https://www.openstack.org/) ist ein sehr mächtiges Framework für die Verwaltung einer Public Cloud Infrastruktur. Leider ist es nicht auf Skalierbarkeit ausgelegt, bietet einige [SPOF](http://de.wikipedia.org/wiki/Single_Point_of_Failure)s und ist generell sehr komplex.

### OpenNebula
[OpenNebula](http://opennebula.org/) nennt sich selbst "Enterprise Ready", benutzt allerdings *xml concats* in C++ anstatt einer XML Bibliothek. Das Interface bietet eine statische Infrastruktur, welche schlecht anpassbar ist. Das Logging enthält größtenteils interne Informationen und wenig Nützliches. Generell ist OpenNebula eine sehr zusammengeschusterte Lösung aus verschiedenen Sprachen (unter anderem Ruby und C++). Um Änderungen an einer bereits laufenden VM zu machen (z.B. die KVM Clock durchreichen) muss diese in der Regel gestoppt werden und die DB von Hand editiert werden (also MySQL CLI). Zu der schlechten Cod- Qualität kommt die Tatsache, dass einige Basis Features nicht funktionieren (Storage-/CD-Hotplug). Features Requests werden des öfteren im Backlog nach hinten geschoben.

### Archipel
[Archipel](http://archipelproject.org/) ist eine Webapp, welche komplett im Browser läuft und via Websockets mit dem Server kommuniziert. Zur Kommunikation läuft auf jedem Node ein Agent, der via XMPP angesprochen wird. Leider hat Archipel nur einen Entwickler, das Projekt kommt somit nur langsam voran und weist zu viele Bugs auf. 

---

## Entity Relationship Modell
![virtapi ERD](database/images/virtapi.svg)

---

## Use Cases

### Definieren von Virtualisierungstechniken

### Hinzufügen von Nodes

### Hinzufügen eines IPv4 Netzes

### Eintragen einer virtuellen Maschine

### Übersicht aller Hypervisor und deren unterstützten Techniken
Dies ist notwendig, um einen schnellen Überblick über seine Hypervisor sowie deren unterstützte Techniken zu bekommen.
```sql
SELECT
  `node`.`FQDN`, `virt_method`.`name` -- specify the tables and attributes you want to have 
FROM
  `node` -- specify the tables again
INNER JOIN
  `virt_node` -- where do we want to join
ON
  `node`.`id` = `virt_node`.`node_id` -- which attributes should be the same
INNER JOIN -- first join for N:M, check PK of first table with N:M table
  `node_method`
ON
  `virt_node`.`id` = `node_method`.`virt_node_id`
INNER JOIN -- second join for N:M, check N:M table with PK of second table
  `virt_method`
ON
  `node_method`.`virt_method_id` = `virt_method`.`id`;
```

### Installation einer VM
Dies wird via [installimage](http://wiki.hetzner.de/index.php/Installimage) implementiert:
+ PXE Eintrag setzen
+ VM rebooten
+ VM bootet Live Linux
+ via Kernel-Parameter wird ein Autostart-Script angegeben (das *installimage*) + config (welches OS,...)

---

## Kontakt
Auf freenode gibt es den IRC Channel #virtapi, hier findet man immer einen der Entwickler und kann Bugs/Features diskutieren.

---

## Links und Quellen
+ [API Design Guide](https://github.com/interagent/http-api-design) basierend auf der Heroku Platform
+ [FileBin API](https://wiki.server-speed.net/projects/filebin/api)
+ [Ceph Talk auf der GPN15](https://media.ccc.de/browse/conferences/gpn/gpn15/gpn15-6629-ceph.html#video)
