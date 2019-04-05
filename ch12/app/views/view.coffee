# Listing 12.8  views/view.coffee

class View
  render: ->
    'Lost?'

  wrap: (content) ->
    """
    <!DOCTYPE html>
    <html dir=ltr' lang='en-US'>
    <head>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
    <title>Agtron's blog</title>
    #{content}
    """

exports.View = View
