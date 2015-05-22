## Add a vm state
----
  Insert one new vm state into the database (e.g. "running") and a description of it. Return content is the id of the new state.

* **URL**

  /vm_states/

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
Each VM can only have one current state. We do not track the state history of a VM, several VMs can have the same state
