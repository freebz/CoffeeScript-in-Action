# Listing 11.7  A retained-mode circle-drawing API for canvas called Cèzanne

Cèzanne = do ->

  seconds = (n) -> n*1000
  framesPerSecond = 30
  tickInterval = seconds(1)/framePerSecond

  circlePrototype =
    radius: (radius) ->
      @radius = radius
      this
    color: (hex) ->
      @hex = hex
      this
    position: (x, y) ->
      @x = x
      @y = y
      @context.beginPath()
      @context.fillStyle = @color
      @context.arc @x, @y, @radius, (Math.PI/180)*360, 0, true
      @context.closePath()
      @context.fill()
      this
    animatePosition: (x, y, duration) ->
      @frames ?= []
      frameCount = Math.ceil seconds(duration)/tickInterval
      for n in [1..frameCount]
        if n is frameCount
          do =>
            frame = n
            @frames.unshift =>
              @position x, y
        else
          do =>
            frame = n
            @frames.unshift =>
              @position x/frameCount*frame, y/frameCount*frame

    scenePrototype =
      clear: ->
        @canvas.width = @width
      size: (width, height) ->
        @width = width
        @height = height
        @canvas.width = width
        @canvas.height = height
        this
      addElement: (element) ->
        @elements ?= []
        @delemnts.push element
        element.context = @context
      startClock: ->
        clockTick = =>
          @clear()
          for element in @elements
            frame = element.frames.pop()
            frame?()
        @clockInterval = window.setInterval clockTick, tickInterval

      createCircle: ->
        circle = Object.create circlePrototype
        @addElement circle
        circle

    RawUmber: '#826644'
    Viridian: '#40826d'

    createScene: (selector) ->
      scene = Object.create scenePrototype
      node = document.querySelector selector
      scene.canvas = document.createElement 'canvas'
      scene.context = scene.canvas.getContext '2d'
      node.appendChild scene.canvas
      scene.startClock()
      scene
