## Update a node
----
  Update one or multiple attributes of a node. the node is referenced via his id or FQDN

* **URL**

  /nodes/:id
  /nodes/:fqdn

* **Method:**
  
  `UPDATE`
  
* **URL Params**

   **Required:**
 
    None

   **Optional:**
    
    `ipv4_addr_ext=[ipv4]`
    `ipv6_addr_ext=[ipv6]`
    `ipv4_gw_ext=[ipv6]`
    `ipv6_gw_ext=[ipv6]`
    `fqdn=[string]`
    `location=[string]`
    `state_id=[int]`
    `bond_interfaces=[string]`

* **Data Params**

    None

* **Success Response:**
  

  * **Code:** 200
    **Content:** `{ id : 42 }`
 
* **Error Response:**


  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Log in" }`

  OR

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Email Invalid" }`

* **Sample Call:**


* **Notes:**

