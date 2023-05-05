import plusplus

import "../api_main/main.nim" as main

ID:
  idMessageOfTheDay = "motd"
  idInventoryList = "inventory-list"

CALLABLE():
  proc getMOTD() {.exportc.} =
    let motdH3 = getElementById(cstring(idMessageOfTheDay))
    motdH3.innerHtml = "Super sale today!"
    let petObj = main.getInventory()
    let petListUL = getElementById(cstring(idInventoryList))
    for item in petObj.species:
      let pet = document.createElement(cstring("li"))
      let petName = document.createTextNode(cstring(item))
      pet.appendChild petName
      petListUL.appendChild pet

PAGE():
  head:
    title: text "Pet Shop"
  body( onload = getMOTD ):
    h1: text "Pet Shop"
    p:
      italic: text "A place to buy pets"
    h3( id = idMessageOfTheDay ): text "one moment..."
    h2: text "Current Inventory"
    ul( id = idInventoryList )

# JS():
#   echo "hello world"

# AJAX():

# CALLABLE():
#   proc getInventory() {.exportc.} =
#     let petListUL = getElementById(cstring(idInventoryList))
#     for item in ["Cat", "Dog", "Rabbit"]:
#       let pet = document.createElement(cstring("li"))
#       let petName = document.createTextNode(cstring(item))
#       pet.appendChild petName
#       petListUL.appendChild pet
