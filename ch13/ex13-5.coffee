# Listing 13.5  Formulaic using Proxy

throw new Error 'Proxy required' unless Proxy?

class Formulaic

  constructor: (@root, @selector, @http, @url) ->
    @source = @root.querySelector @selector
    @handler =
      get: (target, property) ->
        target[property]?.value
      set: (target, property, value) =>
        if @valid property then @sync()
    @fields = new Proxy @source, @handler

  valid: (property) ->
    property isnt ''

  addField: (field, value) ->
    throw new Error "Can't append to DOM" unless @source.appendChild?

    newField = @root.createElement 'input'
    newField.value = value
    @source.appendChild newField

  sync: ->
    throw new Error 'No HTTP specified' unless @http? and @url?

    @http.post @url, JSON.stringify(@fields), (response) =>  #B
      for field, fieldResponse of JSON.parse response
        if field of @source
          @source[field].value = fieldResponse.value
        else
          @addField field, fieldResponse.value
