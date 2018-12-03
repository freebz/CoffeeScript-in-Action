# Listing 3.6  Serve multiple files

fs = require 'fs'
http = require 'http'

makeMostRecent = (file1, file2) ->
  mostRecent = 'Nothing read yet.'

  sourceFileWatcher = (fileName) ->
    sourceFileReader = ->
      fs.readFile fileName, 'utf-8', (error, data) ->
        mostRecent = data
    fs.watch fileName, sourceFileReader

  sourceFileWatcher file1
  sourceFileWatcher file2

  getMostRecent = ->
    mostRecent

makeServer = ->
  mostRecent = makeMostRecent 'file1.txt', 'file2.txt'

  server = http.createServer (request, response) ->
    response.write mostRecent()
    response.end()

  server.listen '8080', '127.0.0.1'

server = makeServer()
