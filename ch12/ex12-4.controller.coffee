# Listing 12.4  controllers/controller.coffee

class Controller
  routes = {}

  @route = (path, method) ->
    routes[path ] = method

  constructor: (server) ->
    server.on 'request', (req, res) =>
      path = require('url').parse(request.url).pathname
      handlers = []
      for route, handler of routes
        if new RegExp("^#{route}$").test(path)
          handlers.push
            handler: handler
            matches: path.match(new RegExp("^#{route}$"))
      method = handlers[0]?.handler || 'default'
      res.end @[method](req,res.handlers[0]?.matches.slice(1)...)

  render: (view) ->
    @response.writeHead 200, 'Content-Type': 'text/html'
    @response.end view.render()

  default: (@request, @response) ->
    @render render: -> 'unknown'

exports.Controller = Controller
