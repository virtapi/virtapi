## /virt_node

```javascript
virt_node = {
  id: int,
  local_storage_gb: nullable int, // storage amount in gigabyte
  vg_name: nullable string, // LVM2 VG name
  local_storage_path: nullable string, // path to directory for VM images
  node: {
    id: int,
  }
  virt_method: {
    id: int,
  }
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `virt_node` objects. |
| POST | Adds a new role based on the virtualization node type.  |
| DELETE | Removes a specific role. Only `virt_node.id` has to be set. |
| UPDATE | Updates a specific role. `virt_node.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current virtualization role object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

every node with this role will be able to host virtual machines (openstack slang: it's a compute node). One role is assigned to one node ([/node](node.md)). During a POST call, you can mention the id of an already existing node OR provide all needed attributes/values that are needed for a node and create a new one. Every node with a virt_node role can support multiple virtualization technologies ([/virt_method](virt_method.md)). Each supported technology is provided via the `virt_node.virt_method` attribute. You can create the method if you provide the needed attributes. It is possible to add the `virt_node.virt_method` several times to assign several methods to one role.

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

Call to create a new virtualization role instance (with a local LVM2 VG for VMs):
```
$ curl -H "Content-Type: application/json" -X POST -d $data $base/virt_node
```

$data is:
```javascript
{
  local_storage_gb: 2500,
  vg_name: "vg0",
  node: {
    id: 5,
  }
  virt_method: {
    name: "Qemu",
  }
}
```

response:
```javascript
responseSuccess: {
  status: "success",
  data: {
    id: 815,
  },
}
```

This will assign the `virt_node` role to the existing node with id 5. It will also create a new virtualization technology, named "Qemu", which the node will support. The response contains the status and the id of the new role.
