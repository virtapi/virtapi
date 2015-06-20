## /storage

```javascript
storage = {
  id: int,
  size: Bytes (int),
  write_iops_limit: int,
  read_iops_limit: int,
  write_bps_limit: nullable int, // bytes per second
  read_bps_limit: nullable int, // bytes per second
  vm: {
    id: int,
  }
  cache_option: {
    id: int,
  }
  storage_type: {
    id: int,
  }
}
```

| Verb | Notes |
|------|-------|
| GET  | Returns a list of `storage` objects. |
| POST | Adds a new persistent block storage. `storage.id` is ignored. The `storage.*limit` attributes aren't necessary. |
| DELETE | Removes a storage device. Only `storage.id` has to be set. |
| UPDATE | Updates a block device. `storage.id` is required, additional values set will be updated. |

### Response

All verbs except DELETE return the new/current block storage object(s), DELETE returns the deleted object(s).

### Errors

| Error ID | Message | Notes |
|----------|---------|-------|
| example id | message  | notes |

### Notes

There is also a dedicated endpoint to modify the cache options ([/cache_options](cache_options.md)) and the different storage types ([/storage_type](storage_type.md)). Virtual machines are managed via the [/vm](vm.md) endpoint.

### Version history

| Version | Notes |
|---------|-------|
| 1.0.0 | Add this endpoint. |

### Example

```
Some example calls/returns here.
```
