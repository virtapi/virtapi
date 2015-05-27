## Add a node
----
  Insert one new node into the database (including all attributes). Return content is the id of the new node.

* **URL**

  /nodes/

* **Method:**
  
  `POST`
  
* **URL Params**

   **Required:**
 
   `ipv4_addr_ext=[ipv4]`
   `ipv6_addr_ext=[ipv6]`
   `ipv4_gw_ext=[ipv6]`
   `ipv6_gw_ext=[ipv6]`
   `fqdn=[string]`
   `location=[string]`
   `state_id=[int]`

   **Optional:**
 
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

