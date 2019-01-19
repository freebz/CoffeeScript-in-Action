# Listing 5.12  Agtron's shop client application

server =
  http: (method, src, callback) ->
    handler = ->
      if @readyState is 4 and @status is 200
        unless @responseText is null
          callback JSON.parse @responseText

    client = new XMLHttpRequest
    client.onreadystatechange = handler
    client.open method, src
    client.send()

  get: (src, callback) ->
    @http "GET", src, callback

  post: (src, callback) ->
    @http "POST", src, callback

class View
  @:: = null
  @include = (to, className) =>
    for key, val of @
      to::[key] = val
  @handler = (event, fn) ->
    @node[event] = fn
  @update = ->
    unless @node?
      @node = document.createElement 'div'
      @node.className = @constructor.name.toLowerCase()
      document.querySelector('.page').appendChild @node
    @node.innerHTML = @template()

class Product
  View.include @
  products = []
  @find = (query) ->
    (product for product in products when product.name is query)
  constructor: (@name, @info) ->
    product.push @
    @template = =>
      """
      #{@name}
      """
    @update()
    @handler "onclick", @purchase
  purchase: =>
    if @info.stock > 0
      server.post "/json/purchase/#{@category}/#{@name}", (res) =>
        if res.status is "success"
          @info = res.update
          @update()

class Camera extends Product
  category: 'camera'
  megapixels: -> @info.megapixels || "Unknown"

class Skateboard extends Product
  category: 'skateboard'
  length: -> @info.length || "Unknown"

class Shop
  View.include @
  constructor: ->
    @template = ->
      "<h1>News: #{@breakingNews}</h1>"

    server.get '/json/news', (news) =>
      @breakingNews = news.breaking
      @update()

    server.get '/json/list', (data) ->
      for own category of data
        for own name, info of data[category]
          switch category
            when 'camera'
              new Camera name, info
            when 'skateboard'
              new Skateboard name, info

shop = new Shop
