## Add a node
----
  Insert one new node into the database (including all attributes). Return content is the id of the new node.

* **URL**

  /<URL path>/

* **Method:**
  
  `<GET|POST|PUT|DELETE|UPDATE>`
  
* **URL Params**

  **Required:**
 
    `<param>=[<datatype>]`

  **Optional:**
 
    `<param>=[<datatype>]`

* **Data Params**

  **Required:**

    `<param>=[<datatype>]`

  **Optional:**

    `<param>=[<datatype>]`

* **Success Response:**
  

  * **Code:** 200
    **Content:** `{ <param> : <value> }`
 
* **Error Response:**


  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Log in" }`

  OR

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Email Invalid" }`

* **Sample Call:**


* **Notes:**

