# Listing 8.6  ScruffyCoffee with eval nd regular expressions

fs = require 'fs'
coffee = require 'coffee-script'

evalScruffyCoffeeFile = (fileName) ->
  fs.readFile fileName, 'utf-8', (err, source) ->
    coffeeCode = source.replace /λ([a-zA-Z]+)[.]([a-zA-Z]+)/g, '($1) -> $2'
    coffee.eval coffeeCode

fileName = process.argv[2]
unless fileName
  console.log 'No file specified'
  process.exit()
evalScrufyyCoffeeFile fileName
