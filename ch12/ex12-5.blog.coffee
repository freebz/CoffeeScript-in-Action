# Listing 12.5  controllers/blog.coffee

fs = require 'fs'
{Controller} = require './controller'
{Post} = require '../models'
{Views} = require '../views'

class Blog extends Controller

  @route '/', 'index'
  index: (@request, @response) =>
    @posts = Post.all()
    @render views 'list', @posts

  @route '/([a-zA-Z0-9-]+)', 'show'
  show: (@request, @response, id) =>
    @post = Post.get id
    if @post
      @render views 'post', @post
    else ''

exports.Blog = Blog
