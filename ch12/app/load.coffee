# Listing 12.3  load.coffee

fs = require 'fs'
{Post} = require './models/post'

load = (dir) ->
  fs.readdir dir, (err, files) ->
    for file in files when /.*[.]md$/.test file
      fs.readFile "#{dir}/#{file}", 'utf-8', (err, data) ->
        [title, content...] = data.split '\n'
        new Post title, content.join '\n'

exports.load = load
