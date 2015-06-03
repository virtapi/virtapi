## General  notes

### URLs

The URLs for API endpoints start with the base URL followed by `/api/`, the version supported by the client and the endpoint. For example: `https://example.com/api/v1.0.0/some/endpoint`.

The version number follows the [semantic versioning guidelines](http://semver.org/). The requested version number must be of the format `vX[.X[.X]]` with X being a positive number. `v1` and `v1.0` will both be treated as `v1.0.0`.

The most recent API version is `v0.1.0`.

### Compatibility

The API will evolve by adding and removing endpoints, parameters and keywords. Unknown keywords should be treated gracefully by your application.

Behavior not documented here should not be expected to be available and may be changed without notice.

### Unless stated otherwise ...

Exceptions to the rules stated below will be mentioned in the documentation of affected each endpoint.

- Access is only possible with authentication as described below.
- Size values are expected and returned in bytes.
- Values returned might be bound to the authenticated user and might therefore be different for others.

### Authentication

TODO

### Response structure

Responses will always be of the form described as the value of the response variable below. Any reply not conforming to this format can be considered an error.

```javascript
// Type definitions
Status = String, // one of ["error", "success"] 

response = {
  "status": Status (String),
}

responseSuccess = {
  "status": "success",
  "data": object or array, // defined per endpoint
}

responseError = {
  "status": "error",
  "error_id": "program/userable/error/id",
  "message": "A message that can be displayed to the user",
  "data:" object or array, // additional information, only used if mentioned for a specific error
```

### Errors

You can convert errors to exceptions in your client and use `error_id` to selectivly catch them when necessary. Possible values for `error_id` are described below and on each endpoint page.

#### General errors
| Error ID | Message | Notes |
|----------|---------|-------|
| general/authentication/required | Authentication is required to access this ressource. | |
| general/authentication/failed | The authentication information you supplied was invalid. | |


## Endpoints

### Request structure

Endpoints generally accept multiple values to be sent in a serialized fashion (JSON) in the request body when called via POST or UPDATE.

### Filtering

TODO: some way to filter responses to a GET request based on keys

### Inline nested responses

In case you know which information you require and want to reduce round trips you can request nested foreign key data to be included in the response by setting the GET paramter `nest` to a list of comma separated values you want to be inlined.

Please ensure that inlining the information you need is really better than separately requesting and reusing the information from a dedicated endpoint as this feature may increase the response size drastically.

```
TODO: example
```

## API development guidelines

### Return objects

To reduce backwards incompatible changes never return simple lists of values, always returns objects even if you only set one value in the object. 

### Return keyed objects

If you return an object with a unqiue key always use the value of this key as the key for the object. This allows for easier lookups if data is cross referenced and for easier testing since the test code can use the key to find data it expects. This is especially important if the data used by a test consists of more than one value because a list can be in arbitray order.

```javascript
response.data = {
  42: {
    "id": 42,
    "name": "Joe",
    },
  43: {
    "id": 43,
    "name": "Bob",
  },
}
```
