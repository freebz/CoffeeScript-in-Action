# Listing 12.10  views/post.coffee

{View} = require './view'

class Post extends View
  constructor: (@post) ->
  render: ->
    @wrap """
    <h1>#{@post.title}</h1>
    <div class='content'>
    #{@post.body}
    </div>
    """

exports.Post = Post
