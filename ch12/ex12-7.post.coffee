# Listing 12.7  models/post.coffee

{Model} = require './model'

class Post extends Model
  posts = []
  constructor: (@title, @body) ->
    throw 'requires title' unless @title
    super
    @slug = @dirify @title
    posts.push @

  @all: -> posts

  @get: (slug) -> (post for post in posts when post.slug is slug)[0]

  @purge = ->
    posts = []

exports.Post = Post
