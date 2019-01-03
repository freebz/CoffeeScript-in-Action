# Listing 4.7  Page views revisited

views =
  clear: ->
    @pages = {}
  increment: (key) ->
    @pages ?= {}
    @pages[key] ?= 0
    @pages[key] = @pages[key] + 1
  total: ->
    sum = 0
    for own page, count of @pages
      sum = sum + count
    sum
