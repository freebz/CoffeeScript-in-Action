# Listing 8.4  A basic DSL for HTML

doctype = (variant) ->
  switch variant
    when 5
      "<!DOCTYPE html"

markup = (wrapper) ->
  (attributes..., decendents) ->
    attributesMarkup = if attributes.length is 1
    ' ' + ("#{name}='#{value}'" for name, value of attributes[0]).join ' '
    else
      ''
    "<#{wrapper}#{attributesMarkup}>#{descendents() || ''}</#{wrapper}>"

html = markup 'html'
body = markup 'body'
ul = markup 'ul'
li = markup 'li'
