import
  plusplus

type
  PetList* = object
    species*: seq[string]

PATH:
  pathInventoryAll = "/api/v1.0/inventory/all"

ROUTE(HttpGet, pathInventoryAll):
  proc getInventory*(): PetList =
    result.species = @["Cat", "Dog", "Rabbit"]

SERVER()
