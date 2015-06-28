## /storage_type

```javascript
storage_type = {
  id: int,
  name: string,
  description: string,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `storage_type` objects. |
| POST | Adds a new storage type for persistent storage devices ([/storage](storage.md)). `storage_type.id` is ignored. The `storage_type.name` and `storage_type.description` attributes must be unique. |
| DELETE | Removes a storage type. Only `storage_type.id` has to be set. |
| UPDATE | Updates a storage type. `storage_type.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current storage types object(s), DELETE returns the deleted object(s).

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
