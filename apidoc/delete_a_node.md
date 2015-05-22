## Delete a node
----
  Delete a specific node. He is referenced via his id or FQDN

* **URL**

  /nodes/:id
  /node/:fqdn

* **Method:**
  
  `DELETE`
  
* **URL Params**

   **Required:**
 
   `fqdn=[string]` or `id=[int]`

   **Optional:**

    Node

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
This will also delete all referenced resources based on his roles. For example all local saved virtual maschines.
