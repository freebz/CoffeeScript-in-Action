# Listing 8.2  An object literal-based DSL for email (email.coffee)

simplesmtp = require 'simplesmtp'

class Email
  SMTP_PORT = 25
  SMTP_SERVER = 'coffeescriptinaction.com'
  constructor: ({@to, @from, @subject, @body}) ->

  send: ->
    @client = simplesmtp.connect SMTP_PORT, SMTP_SERVER
    @client.once 'idle', ->
      @client.useEnvelope
        from: @from
        to: @to

    @client.on 'message', ->
      client.write """
      From: #{@from}
      To: #{@to}
      Subject: #{@subject}

      #{@body}
      """
      client.end()
