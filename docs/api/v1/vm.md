## /vm

```
vm = {
  id: int,
  cores: int,
  ram: Megabytes (int),
  customer_id: int,
  cputime_limit: int,
  uuid: UUID (String),
  state: {
    id: StateID (int),
    name: String,
    description: String,
  },
  virt_method_id: {
    id: int,
    virt_method_id: {
      id: int,
      name: string,
    },
    virt_node_id: int,
  },
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `vm` objects. |
| POST | Adds a new vm. `vm.id` is ignored. |
| DELETE | Removes a vm. Only `vm.id` has to be set. |
| UPDATE | Updates a vm. `vm.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current vm object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| vms/invalid/email | The email address is invalid | |

### Notes

a `POST` call will create a VM and a network interface without a VLAN, but with a free IPv4 and IPv6 address. You might want to create a blockdevice (/storage) and assign it to the new VM.

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
