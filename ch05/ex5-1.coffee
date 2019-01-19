# Listing 5.1  A simple Camera class

class Camera
  constructor: (name, info) ->
    @name = name
    @info = info
  render: ->
    "#{@name}: #{@info.description} (#{@info.stock} in stock)"
  purchase: ->
