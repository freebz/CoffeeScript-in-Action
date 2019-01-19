# Listing 5.4  Agtron's shop client application with find

# http. get and post functions omitted - see listing 5.2

class Product
  products = []

  @find = (query) ->
    for product in products
      product.unmark()
    for product in products when product.name is query
      product.mark()
      product

  constructor: (name, info) ->
    products.push @
    @name = name
    @info = info
    @view = document.createElement 'div'
    @view.className = "product"
    document.body.appendChild @view
    @view.onclick = =>
      @purchase()
    @render()

  render: ->
    show = ("<div>#{key}: #{val}</div>" for own key, val of @info).join ''
    @view.innerHTML = "#{@name} #{show}"

  purchase: ->
    if @info.stock > 0
      post "/json/purchase/#{@purchaseCategory}/#{@name}", (res) =>
        if res.status is "success"
          @info = res.update
          @render()

  mark: ->
    @view.style.border = "1px solid black"

  unmark: ->
    @view.style.border = "none"

# class Camera omitted - see listing 5.3
# class Skateboard omitted - see listing 5.3

class Shop
  constructor: ->
    @view = document.createElement 'input'
    @view.onchange = ->
      Product.find @value
    document.body.appendChild @view
    @render()
    get '/json/list', (data) ->
      for own category of data
        for own name, info of data[category]
          switch category
            when 'camera'
              new Camera name, info
            when 'skateboard'
              new Skateboard name, info

  render: ->
    @view.innerHTML = ""

shop = new Shop
