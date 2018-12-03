# Listing 3.3  Cat utility

fs = require 'fs'

file = process.argv[2]
fs.readFile file, 'utf-8', (error, contents) ->
  if error
    console.log error
  else
    console.log contents
