# Listing 6.4  State in program or external?

http = require 'http'
db = (require './db').stock

stock = 30
serverOne = http.createServer (req, res) ->
  response = switch req.url
    when '/purchase'
      res.writeHead 200, 'Content-Type': 'text/plain;charset=utf8'
      if stock > 0
        stock = stock - 1
        "Purchased! There are #{stock} left."
      else
        'Sorry! no stock left!'
    else
      res.writeHead 404, 'Content-Type': 'text/plain;charset=utf8'
      'Go to /purchase'
  res.end response

serverTwo = http.createServer (req, res) ->
  purchase = (callback) ->
    db.decr 'stock', (error, response) ->
      if error
        callback 0
      else
        callback response

  render = (stock) ->
    res.writeHead 200, 'Content-type': 'text/plain;charset=utf8'
    response = if stock > 0
      "Purchased! There are #{stock} left."
    else
      'Sorry! no stock left'
    res.end response

  switch req.url
    when '/purchase'
      purchase render
    else
      res.writeHead 404, 'Content-Type': 'text/plain;charset=utf8'
      res.end 'Go to /purchase'

serverOne.listen 9091, '127.0.0.1'
serverTwo.listen 9092, '127..0.0.1'
