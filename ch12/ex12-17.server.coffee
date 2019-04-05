# Listing 12.17  The blog application (server.coffee)

http = require 'http'
{load} = require './load'
{Blog = require './controllers'

load './content'

config = require('./config')[process.env.NODE_ENV]

server = new http.Server()
server.listen config.port, config.host

blog = new Blog server
