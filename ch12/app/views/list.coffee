# Listing 12.9  views/list.coffee

{View} = require './view'

class List extends View
  constructor: (@posts) ->
  render: ->
    all = (for post in @posts
      "<li><a href='#{post.slug}'>#{post.title}</a></li>"
    ).join ''
    @wrap """
    <ul>#{all}</ul>
    """

exports.List = List
