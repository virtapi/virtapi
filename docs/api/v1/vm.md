## /vm

```javascript
vm = {
  id: int,
  cores: int,
  ram: Bytes (int),
  customer_id: nullable int,
  cputime_limit: nullable int,
  uuid: nullable UUID (String),
  node: nullable {
    id: int,
  },
  virt_method: {
      id: int,
  },
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `vm` objects. |
| POST | Adds a new vm. `vm.id` is ignored. The UUID will be auto generated if you don't provide it. |
| DELETE | Removes a vm. Only `vm.id` has to be set. |
| UPDATE | Updates a vm. `vm.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current vm object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the vm states ([/vm_state](vm_state.md)), the virtualization technologies ([/virt_method](virt_method.md)) and the node ([/node](node.md)).

Broken Parallels software uses UUIDs to identify their containers and virtual machines, but it is possible that multiple containers have the same UUID, so this isn't a unique value and also not our primary key. 

A `POST` call will create a VM and a network interface without a VLAN, but with a free IPv4 and IPv6 address. You might want to create a blockdevice [(/storage](storage.md)) and assign it to the new VM. The `cputime_limit` refers to the [period setting](https://libvirt.org/formatdomain.html#elementsCPUTuning) in the [Qemu driver for cgroups cpu controller](https://libvirt.org/cgroups.html) documentation. You need to set `vm.virt_method.id` which specifies only the needed hypervisor technology (for example KVM) and the API itself will choose a suitable host system.It is also possible to provide `vm.node.id`, this will assign the new VM to an existing node. Your call will fail if the provided Node doesn't exists. 

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

Call to creata a new virtual machine
```
$ curl -H "Content-Type: application/json" -X POST -d $data $base/vm
```

$data is:
```javascript
{
  cores:2,
  ram:1073741824,
  virt_method: {
    id: 1
  },
}'
```

response:
```javascript
responseSuccess: {
  status: "success",
  data: {
    id: 5,
  },
}
```

This creates a new virtual machine with 2 CPU cores and 1GB of ram without a block device and with the hypervisor with id 1. The response contains the status and the id of the new VM.
