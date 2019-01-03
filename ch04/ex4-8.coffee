# Listing 4.8  A page views class

class Views
  constructor: ->
    @pages = {}
  increment: (key) ->
    @pages[key] ?= 0
    @pages[key] = @pages[key] + 1
  total: () ->
    sum = 0
    for own url, count of @pages
      sum = sum + count
    sum

businessViews = new Views
personalViews = new Views
