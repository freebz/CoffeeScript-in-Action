# Listing 10.7  The test helper

dependencies =
  'Tracking': '../tracking'
  'User': '../user'
  'fact': '../fact'

for dependency, path of dependencies
  exports[dependency] = require(path) [dependency]
