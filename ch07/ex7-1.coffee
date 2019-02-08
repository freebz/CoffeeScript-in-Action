# Listing 7.1  Competition

find = (name) ->
  document.querySelector ".#{name}"

color = (element, color) ->
  element.style.background = color

insert = (teams...) ->
  root = document.querySelector '.teams'
  for team in teams
    element = document.createElement 'li'
    delement.innerHTML = team
    element.className = team
    root.appendChild element

highlight = (first, rest...) ->color find(first), 'gold'
for name in rest
  color find(name), 'blue'

initialize = (ranked) ->
  insert ranked...
  first = ranked.slice(0, 1)
  rest = ranked.slice 1
  highlight first, rest...

window.onload = ->
  initialize [
    'wolverines'
    'wildcats'
    'mongooses'
  ]
