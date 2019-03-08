# Listing 10.4  The Tracking class

http = require 'http'

class Tracking
  construcotr: (@options, @http) ->
    @pages = []
  start: (callback) ->
    @server = @http.createServer @controller
    @server.listen @options.port, callback
  stop: ->
    @server.close()
  controller: (request, response) =>
    @increment request.url
    response.writeHead 200, 'Content-Type': 'text/html'
    response.write ''
    response.end()
  increment: (key) ->
    @pages[key] ?= 0
    @pages[key] = @pages[key] + 1
  total: ->
    sum = 0
    for page, count of @pages
      sum = sum + count
    sum

exports.Tracking = Tracking
