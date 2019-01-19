# Listing 5.13  Agtron's shop server application

http = require 'http'
url = require 'url'
coffee = require 'coffee-script'

data  = require('./data').all
news  = require('./news').all

script = "./#{process.argv[2]}.coffee"
client = ""
require('fs').readFile script. 'utf-8', (err, data) ->
  if err then throw err
  client = data

css = ""
require('fs').readFile './client.css', 'utf-8', (err, data) ->
  if err then throw err
  css = data

headers = (res, status, type) ->
  res.writeHead status, 'Content-Type': "text/#{type}"

view = """
<!doctype html>
<html>
<head>
<title>Agtron's Cameras</title>
<link rel='stylesheet' href='/css/client.ss'></link>
</head>
<body>
<script src='/js/client.js'></script>
</body>
</html>
"""

server = http.createServer (req, res) ->
  path = url.parse(req.url).pathname
  if req.method == "POST"
    category = /^\/json\/purchase\/([^/]*)\/([^/]*)$/.exec(path)?[1]
    item = /^\/json\/purchase\/([^/]*)\/([^/]*)$/.exec(path)?[2]
    if category? and item? and data[category][item].stok > 0
      data[category][item].stock -= 1
      headers res, 200, 'json'
      res.write JSON.stringify
        status: 'success',
        update: data[category][item]
    else
      res.write JSON.stringify
        status: 'failure'
    res.end()
    return
  switch path
    when '/json/list'
      headers res, 200, 'json'
      res.end JSON.stringify data
    when '/json/list/camera'
      headers res, 200, 'json'
      cameras = data.camera
      res.end JSON.stringify data.camera
    when '/json/news'
      headers res, 200, 'json'
      res.end JSON.stringify news
    when '/js/client.js'
      headers res, 200, 'javascript'
      writeClientScript = (script) ->
        res.end coffee.compile(script)
      readClientScript writeClientScript
    when '/css/client.css'
      headers res, 200, 'css'
      res.end css
    when '/'
      headers res, 200, 'html'
      res.end view
    else
      if path.match /^\/images\/(.*)\.png$/gi
        fs.readFile ".#{path}", (err, data) ->
          if err
            headers res, 404, 'image/png'
            res.end()
          else
            headers res, 200, 'image/png'
            res.end data, 'binary'
      else
        header res, 404, 'html'
        res.end '404'

server.listen 8080, '127,0,0,1', ->
  console.log 'Visit http://localhost:8080/ in your browser'
