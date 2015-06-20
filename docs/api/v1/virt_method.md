## /virt_method

```javascript
virt_method = {
  id: int,
  name: string,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `virt_method` objects. |
| POST | Adds a new virtualization method (or hypervisor technology) to the DB, they are implemented on the nodes ([/node](node.md)) via the virt_node ([/virt_node](virt_node.md)) role. |
| DELETE | Removes a virtualization method. Only `virt_method.id` has to be set. |
| UPDATE | Updates a virtualization method. `virt_method.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current virtualization method object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes


### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
