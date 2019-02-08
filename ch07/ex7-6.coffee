# Listing 7.6  The chain function

chain = (receiver) ->
  wrapper = Object.create receiver
  for key, value of wrapper
    if value?.call
      do ->
        proxied = value
        wrapper[key] = (args...) ->
          proxied.call receiver, args...
          wrapper
  wrapper

turtle =
  forward: (distance) ->
    console.log "moving forward by #{distance}"
  rotate: (degrees) ->
    console.log "rotating #{degrees} degrees"

chain(turtle)
.forward(5)
.rotate(90)
