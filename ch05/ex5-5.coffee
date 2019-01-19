# Listing 5.5  Agtron's shop client application with camera gallery

# http, get and post functions omitted from this listing

class Gallery
  constructor: (@photos) ->
  render: ->
    images = for photo in @photos
      "<li><img src='#{photo}' alt='sample photo' /></li>"
    "<ul class=gallery'>#{images.join ''}</ul>"

class Product
  constructor: (name, info) ->
    @name = name
    @info = info
    @view = document.createElement 'div'
    @view.className = 'product'
    document.querySelector('.page').appendChild @view
    @render()
  render: ->
    @view.innerHTML = "#{@name}: #{@info.stock}"

class Camera extends Product
  constructor: (name, info) ->
    @gallery = new Gallery info.gallery
    super name, info
    @view.className += ' camera'
  render: ->
    @view.innerHTML = """
      #{@name} (#{@info.stock})
      #{@gallery.render()}
    """

class Shop
  constructor: ->
    @view = document.createElement 'div'
    document.querySelector('.page').appendChild @view
    document.querySelector('.page').className += ' l55'
    @render()
    get '/json/list', (data) ->
      for own category of data
        for own name, info of data[category]
          switch category
            when 'camera'
              new Camera name, info
            else
              new Product name, info

  render: () ->
    @view.innerHTML = ""

show = new Shop
