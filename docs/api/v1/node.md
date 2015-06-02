## /node

```
node = {
  id: int,
  ipv4_addr_ext: IPAddress4 (String),
  ipv6_addr_ext: IPAddress6 (String),
  ipv4_gw_ext: IPAddress4 (String),
  ipv6_gw_ext: IPAddress6 (String),
  fqdn: String,
  location: String,
  state: {
    id: StateID (int),
    name: String,
    description: String,
  },
  bond_interfaces: nullable String,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `node` objects. |
| POST | Adds a new node. `node.id` is ignored. |
| DELETE | Removes a node. Only `node.id` has to be set. |
| UPDATE | Updates a node. `node.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current node object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| nodes/invalid/email | The email address is invalid | |

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
