# Listing 10.3  Test for the Tracking class

assert = require 'assert'

{fact} = require './fact'
{Tracking} = require './10.4'

fact 'controller responds with 200 header and empty body', ->
  request = url: '/some/url'

  response =
    write: (body) ->
      @body = body
    writeHead: (status) ->
      @status = status
    end: ->
      @ended = true

  tracking = new Tracking
  for view in [1..10]
    tracking.controller request, response

  assert.equal response.status, 200
  assert.equal response.body, ''
  assert.ok response.ended
  assert.equal tracking.pages['/some/url'], 10

fact 'increments once for each key', ->
  tracking = new Tracking
  tracking.increment 'a/page' for i in [1..100]
  tracking.increment 'another/page'

  assert.equal tracking.pages['a/page'], 100
  assert.equal tracking.total(), 101

fact 'starts and stops server', ->
  http =
  createServer: ->
    @created = true
    listen: =>
      @listening = true
    close: =>
      @listening = false

  tracking = new Tracking {}, http
  tracking.start()

  assert.ok http.listening

  tracking.stop()
  assert.ok not http.listening
