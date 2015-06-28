## /cache_option

```javascript
cache_option = {
  id: int,
  name: string,
  description: string,
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `cache_option` objects. |
| POST | Adds a new cache option for persistent storage devices ([/storage](storage.md)). `cache_option.id` is ignored. The `cache_option.name` and `cache_option.description` attributes must be unique. |
| DELETE | Removes a node state. Only `cache_option.id` has to be set. |
| UPDATE | Updates a node state. `cache_option.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current cache option object(s), DELETE returns the deleted object(s).

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
