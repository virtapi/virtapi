## /node

```javascript
node = {
  id: int,
  ipv4_addr_ext: IPAddress4 (String),
  ipv6_addr_ext: IPAddress6 (String),
  ipv4_gw_ext: IPAddress4 (String),
  ipv6_gw_ext: IPAddress6 (String),
  fqdn: String,
  location: nullable String,
  node_state: {
    id: int,
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
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the node states ([/node_state](node_state.md)).

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

Call to creata a new node:
```bash
curl -H "Content-Type: application/json" -X POST -d $data $base/node
```

$data is:
```javascript
{
  ipv4_addr_ext: "192.168.1.10/24",
  ipv6_addr_ext: "2a01:4f8:11a:b2a::1/64",
  ipv4_gw_ext: "192.168.1.1",
  ipv6_gw_ext: "2a01:4f8:11a:b00::1",
  fqdn: "cloudnode1.local",
  node_state: {
    id: 5,
  }
}
```

response:
```javascript
responseSuccess: {
  status: "success",
  data: {
    id: 1337,
  }
}
```

This will create a new node with the given specs, in this example, there is an existing node_state with id 5. The response contains the status and the id of the new node.







