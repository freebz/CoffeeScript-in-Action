# Listing 12.2  server.coffee

http = require 'http'
{load} = require './load'
{Blog} = require './controllers/blog'

load './content'

server = new http.Server()
server.listen '8080', 'localhost'

blog = new Blog server
