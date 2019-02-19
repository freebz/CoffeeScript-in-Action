assert = require 'assert'

class TestElephant
  testWalk: -> assert false

  testForget: -> assert false

test = new TestElephant
for methodName of TestElephant::
  test[methodName]()