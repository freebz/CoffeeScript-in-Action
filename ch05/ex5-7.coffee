# Listing 5.7  CoffeeScript class, constructor, and method compilation

# CoffeeScript

class SteamShovel
  constructor (name) ->
    @name = name
  speak: ->
    "Hurry up!"

gus = new SteamShovel
gus.speak()
