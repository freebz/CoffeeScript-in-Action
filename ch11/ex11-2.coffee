# Listing 11.2  The status updating script

window.onload ->
  status = document.querySelector '#status'

  render = (buffer) ->
    status.style.color = 'green'
    status.style.fontSize = '120px'
    status.innerHTML = buffer[buffer.length-1]

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

  framesPerSecond = (n) ->
    (seconds 1)/n

  makeUpdater = (buffer = []) ->
    bufferRenderer = (json) ->
      buffer.push (JSON.parse json).hits
      render buffer

    ->
      window.setInterval ->
        fetch '/feed.json', bufferRenderer
      , framesPerSecond 20

  updater = makeUpdater()
  updater()
