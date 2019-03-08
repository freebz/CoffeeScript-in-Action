# Listing 10.8  The test runner

fs = require 'fs'
coffee = require 'coffee-script'

test = (file) ->
  fs.readFile file, 'utf-8', (err, data) ->
    it = """
      [tact} = require './fact'
      assert = require 'assert'
      #{data}
    """
    coffee.run it, filename: file

spec = (file) ->
  /[^.]*\.spec\.coffee$/.test file

fs.readdir '.', (err, files) ->
  for file in files
    test file if spec file
