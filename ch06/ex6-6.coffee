# Listing 6.6  Before, after, and around with function binding

before = (decoration) ->
  (base) ->
    (params...) ->
      decoration.apply @, params
      base.apply @, params

after = (decoration) ->
  (base) ->
    (params...) ->
      result = base.apply @, params
      decoration.apply @, params
      result

around = (decoration) ->
  (base) ->
    (params...) ->
      result = undefined
      func = =>
        result = base.apply @, params
      decoration.apply @, ([func].concat params)
      result
