## List all nodes
----
  This will list all available nodes.

* **URL**

  /nodes/

* **Method:**
  
  `GET`
  
* **URL Params**

   **Required:**
 
    None

   **Optional:**
    
    `bond_interfaces=[string]`
    `ipv4_addr_ext=[ipv4]`
    `ipv6_addr_ext=[ipv6]`
    `ipv4_gw_ext=[ipv6]`
    `ipv6_gw_ext=[ipv6]`
    `fqdn=[string]`
    `location=[string]`
    `state_id=[int]`

* **Data Params**

    None

* **Success Response:**
  

  * **Code:** 200
    **Content:** `{{ id : 42, ipv4_addr_ext : '192.168.1.1'... }, { id : 50, ipv4_addr_ext : '192.168.1.2'... }}`
 
* **Error Response:**


  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Log in" }`

  OR

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Email Invalid" }`

* **Sample Call:**


* **Notes:**
You can specify any of the optional params, in that case you get all nodes but just their id + the specified attributes. If none are provided, you get all nodes with all attributes.
