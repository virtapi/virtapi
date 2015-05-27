## Add a node state
----
  Insert one new node state into the database (e.g. "running") and a description of it. Return content is the id of the new state.

* **URL**

  /node_states/

* **Method:**
  
  `POST`
  
* **URL Params**

   **Required:**
 
   `name=[string]`
   `description=[string]`

   **Optional:**
 
    None

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

