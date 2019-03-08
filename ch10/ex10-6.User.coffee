# Listing 10.6  The User class

class user
  constructor: (@options, @http) ->
  visitPage: (url, callback) ->
    @options.path = url
    @options.method = 'GET'
    callback()
  clickMouse: (callback) ->
    request = @http.request @options, (request, response) ->
      callback()
    request.end()

exports.User = User
