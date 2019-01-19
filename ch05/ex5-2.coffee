# Listing 5.2  Agtron's camera shop client application (version 1)

http = (method, src, callback) ->
  handler = ->
    if @readyState is 4 and @status is 200
      unless @responseText is null
        callback JSON.parse @responseText

  client = new XMLHttpRequest
  client.onreadystatechange = handler
  client.open method, src
  client.send()

get = (src, callback) ->
  http "GET", src, callback

post = (src, callback) ->
  http "POST", src, callback

class Camera
  constructor: (name, info) ->
    @name = name
    @info = info
    @view = document.createElement 'div'
    @view.className = "camera"
    document.body.appendChild @view
    @view.onclick = =>
      @purchase()
    @render()

  render: ->
    @view.innerHTML = "#{@name} (#{@info.stock} stock)"

  purchase: ->
    if @info.stock > 0
      post "/json/purchase/camera/#{@name}", (res) =>
        if res.status is "success"
          @info = res.update
          @render()

class Shop
  constructor: ->
    get '/json/list/camera', (data) ->
      for own name, info of data
        new Camera name, info

shop = new Shop
