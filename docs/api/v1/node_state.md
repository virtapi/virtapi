## /node_state

```
node_state = {
  id: int,
  name: string,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `node_state` objects. |
| POST | Adds a new node state. `node_state.id` is ignored. The name must be unique|
| DELETE | Removes a node state. Only `node_state.id` has to be set. |
| UPDATE | Updates a node state. `node_state.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current node state object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the vm states ([/vm_state](vm_state.md)).

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
