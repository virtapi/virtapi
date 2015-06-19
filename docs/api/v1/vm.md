## /vm

```
vm = {
  id: int,
  cores: int,
  ram: Bytes (int),
  customer_id: int,
  cputime_limit: int,
  uuid: UUID (String),
  vm_state: {
    id: int,
  },
  node_method: {
    id: int,
    virt_method: {
      id: int,
      name: string,
    },
  },
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `vm` objects. |
| POST | Adds a new vm. `vm.id` is ignored. The UUID will be auto generated if you don't provide it |
| DELETE | Removes a vm. Only `vm.id` has to be set. |
| UPDATE | Updates a vm. `vm.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current vm object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the vm states ([/vm_state](vm_state.md)).

A `POST` call will create a VM and a network interface without a VLAN, but with a free IPv4 and IPv6 address. You might want to create a blockdevice [(/storage](storage.md)) and assign it to the new VM. The `cputime_limit` refers to the [period setting](https://libvirt.org/formatdomain.html#elementsCPUTuning) in the [Qemu driver for cgroups cpu controller](https://libvirt.org/cgroups.html), . You can set `vm.node_method.id` OR `vm.node_method.virt_method.id`. The first one specifies the hardware node AND the needed hypervisor technology, the second one specifies only the needed hypervisor technology (for example KVM) and the API itself will choose a suitable host system.

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
