# Listing 5.11  Mixin class

class Mixin
  constructor: (methods) ->
    for name, body of methods
      @{name} = body
  include: (klass) ->
    for key, value of @
      klass::[key] = value

htmlRenderer = new Mixin
  render: -> "rendered"

class Camera
  htmlRenderer.include @

leica = new Camera()

leica.render()
#rendered
