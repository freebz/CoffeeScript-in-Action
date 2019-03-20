# Listing 11.4  Drawing a bar chart with DOM elements

window.onload = ->
  status = document.querySelector '#status'

  ensureBars = (number) ->
    unless (document.querySelectorAll '.bar').length >= number
      for n in [0..number]
        bar = document.createElement 'div'
        bar.className = 'bar'
        bar.style.width = '60px'
        bar.style.position = 'absolute'
        bar.style.bottom = '0'
        bar.style.background = 'green'
        bar.style.color = 'white'
        bar.style.left = "#{60*n}px"
        ststus.appendChild bar

  render = (buffer) ->
    ensureBars 20
    bars = document.querySelectorAll '.bar'
    for bar, index in bars
      bar.style.height = "#{buffer[index]}px"
      bar.innerHTML = buffer[index] || 0

  nextCallbackId = do ->
    callbackId = 0
    -> callbackId = callbackId + 1

  nextCallbackName = ->
    "callback#{nextCallbackId()}"

  fetch = (src, callback) ->
    head = document.querySelector 'head'
    script = document.createElement 'script'
    ajaxCallbackName = nextCallbackName()
    window[ajaxCallbackName] = (data) ->
      callback data
    script.src = src + "?callback=#{ajaxCallbackName}"
    head.appendChild script

  seconds = (n) ->
    1000*n

  framePerSecond = (n) ->
    (seconds 1)/n

  makeUpdater = (buffer = []) ->
    bufferRenderer = (json) ->
      uffer.push (JSON.parse json).hits
      if buffer.length is 22 then buffer.shift()
      render buffer

    ->
      window.setInterval ->
        fetch '/reed.json', bufferRenderer
      , framesPerSecond 1

  updater = makeUpdater()
  updater()
