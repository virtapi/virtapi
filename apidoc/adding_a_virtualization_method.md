## adding a virtualization method
----
  Insert one new virtualization method into the database (e.g. KVM). Return content is the id of the new method.

* **URL**

  /virt_methods/

* **Method:**
  
  `POST`
  
* **URL Params**

   **Required:**
 
   `name=[string]`

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

