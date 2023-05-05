# items todo for POC

* insert ID
  * `ID` macro
  * `CLASS` macro
* call from 'onclick', 'onload', etc
  * using string
  * using function name
  * using `call` macro that checks arguments
* insert CSS
  * `CSS` macro
  * using middleware (aka library)
* observability sublib
  * `OBSERVE` macro
  * `SUBSCRIBE` macro


## for video

* web site named "petshop"
  * "all you can do is login and see todays message pets"
  * calls "main" api using include
  * calls a local proc by function name
    * proc invoked by event
  * calls a local proc by `call macro`
    * proc invoked by 
  * uses fancy CSS middleware
  * it DOES NOT call the main api by event
* web site named "customerservice"
  * "all you can do is add a pet"
  * calls "main" api using include
  * calls a local proc by function name
  * calls a local proc by strlit
* api site named "main"
  * "get pet list, add pet, login proxy, get todays message"
  * has SQLITE access middleware for inventory
  * calls "users" api using include for login proxy
* api site named "users"
  * "accepts user if name starts with letter J"
  * just poc
