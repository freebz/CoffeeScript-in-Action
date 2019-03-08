# Listing 10.9  The watcher

#!/usr/bin/env coffee

coffee = require 'coffee-script'
fs     = require 'fs'

SPEC_PATH = './spec/'
SRC_PATH = './src'

test = (file) ->
  fs.readFile SPEC_PATH + file, 'utf-8', (err, data) ->
    it = """
      {fact} = require '../fact'
      assert = require 'assert'
      #{data}
    """
    coffee.run it, filename: SPEC_PATH + file

spec = (file) ->
  if /#/.test file then false
  else /\.spec\.coffee$/.test file

tests = ->
  fs.readdir SPEC_PATH, (err, files) ->
    for file in files
      test file if spec file

fs.watch SPEC_PATH, (event, filename) ->
  tests()

fs.watch SRC_PATH, (event, filename) ->
  tests()
