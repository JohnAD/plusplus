# import std / dom


#proc getInventory*() =
#    let petListUL = getElementById("hello")
#    for item in ["Cat", "Dog", "Rabbit"]:
#      let pet = document.createElement(cstring("li"))
#      pet.name = item
#      petListUL.children.add pet


proc adder*(a, b: int):  int {.exportc.} =
  result = a + b
