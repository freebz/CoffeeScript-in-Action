# Listing 9.5  Controlling paddles in a web browser

withEvents = (emitter, event) ->
  pipeline = []
  data = []

  reset = ->
    pipeline = []

  run = ->
    result = data
    for processor in pipeline
      if processor.filter?
        result = result.filter processor.filter
      else if processor.map?
        result = result.map processor.map
    result

  emitter.on event, (datum) ->
    data.push datum

  filter: (filter) ->
    pipeline.push {filter: filter}
    @
  map: (map) ->
    pipeline.push {map: map}
    @
  drain: (fn) ->
    emitter.on event, (datum) ->
      result = run()
      data = []
      fn result
    evaluate: ->
      result = run()
      reset()
      result

  UP = 38
  DOWN = 40
  Q = 81
  A = 6

  doc =
    on: (event, fn) ->
      old = document["on#{event}"] || ->
      document["on#{event}"] = (e) ->
        old e
        fn e

  class Paddle
    constructor: (@top=0, @left=0) ->
      @render()

    move: (displacement) ->
      @top += displacement*5
      @paddle.style.top = @top + 'px'

    render: ->
      @paddle = document.createElement 'div'
      @paddle.className = 'paddle'
      @paddle.style.backgroundColor = 'black'
      @paddle.style.position = 'absolute'
      @paddle.style.top = "#{@top}px"
      @paddle.style.left = "#{@left}px"
      @paddle.style.width = '20px'
      @paddle.style.height = '100px'
      document.querySelector('#pong').appendChild @paddle

    displacement = ([up,down]) ->
      (event) ->
        switch event.keyCode
          when up then -1
          when down then 1
          else 0

    move = (paddle) ->
      (moves) ->
        for displacement in moves
          paddle.move displacement

    keys = (expected) ->
      (pressed) ->
        pressed.keyCode in expected

    paddle1 = new Paddle 0, 0
    paddle1.keys = [Q,A]

    paddle2 = new Paddle 0, 200
    paddle2.keys = [UP,DOWN]

    withEvnets(doc, 'keydown')
    .filter(keys paddle1.keys)
    .map(displacement paddle1.keys)
    .drain(move paddle1)

    withEvents(doc, 'keydown')
    .filter(keys paddle2.keys)
    .map(displacement paddle2.keys)
    .drain(move paddle2)
