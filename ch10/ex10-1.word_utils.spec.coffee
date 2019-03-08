# Listing 10.1  Add and remove word

assert = require 'assert'

{addWord, removeWord} = require './word_utils'

fact = (description, fn) ->
  try
    fn()
    console.log "#{description}: OK"
  catch e
    console.error "#{description}: \n#{e.stack}"
    throw e

fact "addWord adds a word", ->
  input = "product special"
  expectedOutput = "product special popular"
  actualOutput = addWord input, "popular"

  assert.equal expectedOutput, actualOutput

fact "removeWord removes a word and surrounding whitespace", ->
  tests = [
    initial: "product special"
    replace: "special"
    expected: "product"
  ,
    initial: "product special"
    replace: "spec"
    expected: "product special"
  ]

  for {initial, replace, expected} in tests
    assert.equal removeWord(initial, replace), expected
