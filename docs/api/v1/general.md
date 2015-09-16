## General  notes

### URLs

The URLs for API endpoints start with 
1.  the base URL (`https://example.com`) followed by 
2.  `/api`,
3.  the version supported by the client (`/v.0.1.0`)and 
4.  the endpoint (`/some/endpoint`).
For example: `https://example.com/api/v1.0.0/some/endpoint`.

The version number follows the [semantic versioning guidelines](http://semver.org/). The requested version number must be of the format `vX[.X[.X]]` with X being a positive integer. `v1` and `v1.0` will both be treated as `v1.0.0`.

The most recent API version is `v0.1.0`.

### Compatibility

The API will evolve by adding and removing endpoints, parameters and keywords. Unknown keywords should be treated gracefully by your application.

Behavior not documented here should not be expected to be available and may be changed without notice.

### Unless stated otherwise ...

Exceptions to the rules stated below will be mentioned in the documentation of each affected endpoint.

- Access is only possible with authentication as described below.
- Size values are expected and returned in bytes.
- Values returned might be bound to the authenticated user and might therefore be different for others.

### Authentication

TODO

### Response structure

Responses will always be in the form described as the value of the response variable below. Any reply not conforming to this format can be considered as an error. It is possible that an Object doesn't have all attributes that are defined in the modell. These attributes will be null.

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
  "status_code": number, // the HTTP status code such as 401, 404, ...
  "error_id": "program/useable/error/id",
  "message": "A message that can be displayed to the user",
  "data:" object or array, // additional information, only used if mentioned for a specific error
}
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

Endpoints generally accept multiple values to be sent in a serialized fashion (JSON) in the request body when called via POST or UPDATE. Values that aren't necessary are repesented with `nullable` in the endpoint documentation. In a request, you can send the value `NULL` or ignore the attribute and don't send it.

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

To prohibit too frequent backward incompatible changes never return simple lists of values, always return objects even if you only set one value in the object.

### Return keyed objects

If you return an object with a unqiue key always use the value of this key as the key for the object. This allows for easier lookups if data is cross referenced and for easier testing since the test code can use the key to find the data it expects. This is even more important if the data used by a test consists of more than one value because a list can be in arbitrary order.

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
