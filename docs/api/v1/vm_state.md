## /vm_state

```
vm_state = {
  id: int,
  name: string,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `vm_state` objects. |
| POST | Adds a new node state. `vm_state.id` is ignored. The name must be unique|
| DELETE | Removes a node state. Only `vm_state.id` has to be set. |
| UPDATE | Updates a node state. `vm_state.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current vm state object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the node states ([/node_state](node_state.md)).

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
