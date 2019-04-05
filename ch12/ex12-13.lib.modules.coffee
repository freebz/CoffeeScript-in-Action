# Listing 12.13  require and defmodule for the browser (lib/modules.ccoffee)

do ->
  modules = {}
  cache = {}
  @require = (raw_name) ->
    name = raw_name.replace /[^a-z]/gi, ''
    return cache[name].exports if cache[name]
    if modules[name]
      module = exports: {}
      cache[name] = module
      modules[name]((name) ->
        require name
      , module.exports)
      module.exports
    else throw "No such module #{name}"

  @defmodule = (bundle) ->
    for own key of bundle
      modules[key] = bundle[key]
