## /storage

```javascript
storage = {
  id: int,
  size: Bytes (int),
  write_iops_limit: nullable int,
  read_iops_limit: nullable int,
  write_bps_limit: nullable int, // bytes per second
  read_bps_limit: nullable int, // bytes per second
  vm: {
    id: int,
  }
  cache_option: nullable {
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

Call to create a new virtual machine:
```javascript
$curl -H "Content-Type: application/json" -X POST -d $data $base/storage
```

$data is:
```javascript
{
  size: 53687091200,
  vm: {
    id: 5,
  },
  storage_type: {
    id: 1
  },
}
```

response:
```javascript
responseSuccess: {
  status: "success",
  data: {
    id: 42,
  },
}
```

This creates a 50GB block devices and assigns it to the VM with id 5. the `storage_type` is 1 (in this example: local qcow2 iamge -> puppet will create the image). The new block device has the id 42.
