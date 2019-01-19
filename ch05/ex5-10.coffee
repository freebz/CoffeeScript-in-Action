# Listing 5.10  Agtron's shop client application with stock arrivals

# http omitted
# get omitted
# put omitted

Date::daysFromToday = ->
  millisecondsInDay = 86400000
  today = new Date
  diff = @ - today
  Math.floor diff/millisecondsInDay

class Product
  products = []

  @find = (query) ->
    for product in products
      product.unmakr()
    for product in products when product.name is query
      product.mark()
      product

  constructor: (name, info) ->
    products.push @
    @name = name
    @info = info
    @view = document.createElement 'div'
    @view.className = "product #{@category}"
    document.querySelector('.page').appendChild @view
    @view.onclick = =>
      @purchase()
    @render()

  render: ->
    @view.innerHTML = @template()

  purchase: ->
    if @info.stock > 0
      post "/json/purchase/#{@purchaseCategory}/#{@name}", (res) =>
        @info = res.update
        @render()

  template: =>
    """
    <h2>#{@name}</h2>
    <dl class='info'>
    <dt>Stock</dt> <dd>#{@info.stock}</dd>
    <dt>New stock arrives in</dt>
    <dd>#{new Date(@info.arrives).daysFromToday()} days</dd>
    </dl>
    """

  mark: ->
    @view.style.border = "1px solid black";

  unmark: ->
    @view.style.border = "none";

class Camera extends Product
  category 'camera'
  megapixels: -> @info.megapixels || "Unknown"

class Skateboard extends Product
  category: 'skateboard'
  length: -> @info.length || "Unknown"

class Shop
  constructor: ->
    unless Product::specials?
      Product::specials = []
    @view = document.createElement 'div'
    @render()
    get '/json/list', (data) ->
      for own category of data
        for own name, info of data[category]
          if info.special?
            Product::specials.push info.special
          switch category
            when 'camera'
              new Camera name, info
            when 'skateboard'
              new Skateboard name, info

  render: ->
    @view = document.createElement 'div'
    document.querySelector('.page').appendChild @view
    @view.innerHTML = """
    <form class='search'>
    Search: <input id='search' type='text' />
    <button id='go'>Go</button>
    </form>
    """
    @search = document.querySelector '#search'
    @go = document.querySelector '#go'
    @go.onclick = =>
      Product.find @search.value
      false
    @search.onchange = ->
      Product.find @value
      false

shop = new Shop
