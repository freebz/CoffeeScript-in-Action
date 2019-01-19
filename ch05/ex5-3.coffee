# Listing 5.3  Agtron's shop client application with multiple product categories

# http function omitted - see listing 5.2
# get function omitted - see listing 5.2
# post function omitted - see listing 5.2

class Product
  constructor: (name, info) ->
    @name = name
    @info = info
    @view = document.createElement 'div'
    @view.className = "product"
    document.body.appendChild @view
    @view.onclick = =>
      @purchase()
    @render()

  render: ->
    renderInfo = (key, val) ->
      "<div>#{key}: #{val}</div>"
    displayInfo = (renderInfo(key, val) for own key, val of @info)
    @view.innerHTML = "#{@name} #{displayInfo.join ' '}"

  purchase: ->
    if @info.stock > 0
      post "/json/purchase/#{@purchaseCategory}/#{@name}", (res) =>
        if res.status is "success"
          @info = res.update
          @render()

class Camera extends Product
  purchaseCategory: 'camera'
  megapixels: -> @info.megapixels || "Unknown"

class Skateboard extends Product
  purchaseCategory: 'skateboard'
  length: -> @info.length || "Unknown"

class Shop
  constructor: ->
    get '/json/list', (data) ->
      for own category of data
        for own name, info of data[category]
          switch category
            when 'camera'
              new Camera name, info
            when 'skateboard'
              new Skateboard name, info

shop = new Shop
